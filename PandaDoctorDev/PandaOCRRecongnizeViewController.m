//
//  PandaOCRRecongnizeViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/31.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaOCRRecongnizeViewController.h"
#import "PandaRPCInterface.h"
#import "PandaOCRResultViewController.h"

//error Provide Application ID and Password
// To create an application and obtain a password,
// register at http://cloud.ocrsdk.com/Account/Register
// More info on getting your application id and password at
// http://ocrsdk.com/documentation/faq/#faq3

// Name of application you created
static NSString* MyApplicationID =  @"pandaDoctor"; //@"my_app_id";
// Password should be sent to your e-mail after application was created
static NSString* MyPassword = @"aYMmnhTGoIyg0zXdIhwnn9Tv";  //@"my_password";

@interface PandaOCRRecongnizeViewController ()

@end

@implementation PandaOCRRecongnizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textView.hidden = YES;
    
    _label.hidden = NO;
    _label.text = @"识别中...";
    _ocrTableView.delegate = self;
    _ocrTableView.dataSource = self;
    _ocrTableView.hidden = YES;
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface checkItemsForApp:_checkItemId];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)_dataList.count);
    
    // init post data
    _postArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (int i=0; i<_dataList.count; i++)
    {
        // 字典中, 存放两个值 , 一个是RCRD_ID  也就是post时, checkItemIds的内容,
        // 第二个值, 就是该项的一个化验单值 , 这个值是0,1,3, 我们给定默认值0, 在检查时, 动态修改postArray 里面的值.
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:3];
        [dict setValue:[[_dataList objectAtIndex:i] valueForKey:RCRD_ID] forKey:RCRD_ID];
        [dict setValue:@"0" forKey:RESULT];
        [_postArray addObject:dict]; // dict 存放在array 中
    }
    
    
    NSString *result = @"湖南邵阳县城关镇医院生化检验报告单\r\n姓名：罗文 科别：门诊	性别：男	年龄：22岁 ^号：	标本类型：血		检验编号：100003 备注：	\r\n项目名称	代号	结果	参考值	单位\r\n谷草转氨酶	AST	27.2	5-40	U/L\r\n谷丙转氨酶	ALT	39.9	0-40	U/L\r\n谷草/谷丙	AST/ALT	0.7	1	1-2.5	\r\n碱性磷酸酶	ALP	165.0	1 0-100	U/L |\r\n总蛋白	TP	82.2	60-83	g/L\r\n白蛋白.	ALB	45.8	35-55	g/L\r\n球蛋白	GLB	36.4	20-40	g/L\r\n白/球比例	A/G	1.25	1-2. 5	\r\n总胆红素	TBIL	7.9	0-20. 7	umol/L\r\n直接胆红素	DBIL	3.2	0-6	umol/L\r\n间接红素 乙肝表面抗原	IBIL HBsAg	4.7 . 阳性	0-10	umol/L\r\n送检医生伍小凤	检验日期2010督05	报告日期2010-03-05 检验者刘玲玲\r\n此检验结果仅对此标本负责！";
    
    NSMutableArray *assList = [result componentsSeparatedByString:@"\r\n"];
    
    // asslist 过滤
    for (int i=assList.count-1; i>-1; i--) {
        Boolean contain = NO;
        for (int j=0;j<_dataList.count; j++) {
//            if ([[assList objectAtIndex:i] containsString:[[_dataList objectAtIndex:j] valueForKey:ITEM_NM]] || [[assList objectAtIndex:i] containsString:[[_dataList objectAtIndex:j] valueForKey:ENG_NM]]) {
//                contain = YES;
//                break;
//            }
            
            if ([self containString:[assList objectAtIndex:i] contains:[[_dataList objectAtIndex:j] valueForKey:ITEM_NM]]
                || [self containString:[assList objectAtIndex:i] contains:[[_dataList objectAtIndex:j] valueForKey:ENG_NM]])
            {
                contain = YES;
                NSLog(@"contains");
                break;
            }
        }
        if (!contain) {
            [assList removeObjectAtIndex:i];
        }
        
    }
    _assResultList = [[NSMutableArray alloc]initWithCapacity:3];
    
    for(int i=0; i<_dataList.count; i++) // 循环从server 实际含有的值开始. 每一轮结束, 必须要存入assResultList;
    {
        NSLog(@"i=%d",i);
        NSMutableDictionary *result_dict = [[NSMutableDictionary alloc]initWithCapacity:3]; // 存放结果的字典
        [result_dict setValue:[[_dataList objectAtIndex:i] valueForKey:ITEM_NM] forKey:ITEM_NM]; // 检查项名字填入
        [result_dict setValue:nil forKey:VALUE]; // 初始化检查值为nil
        [result_dict setValue:[[_dataList objectAtIndex:i] valueForKey:RCRD_ID] forKey:RCRD_ID]; // rcrd_id存入字典
        
        for (int j=0; j<assList.count; j++) {
            NSLog(@"j=%d",j);
            //去看每一行这一样里有没有对应的英文缩写或者中文，有就认为找到了对应行
            //if ([[assList objectAtIndex:j] containsString:[[_dataList objectAtIndex:i] valueForKey:ITEM_NM]] || [[assList objectAtIndex:j] containsString:[[_dataList objectAtIndex:i] valueForKey:ENG_NM]])
            if ([self containString:[assList objectAtIndex:j] contains:[[_dataList objectAtIndex:i] valueForKey:ITEM_NM]]
                || [self containString:[assList objectAtIndex:j] contains:[[_dataList objectAtIndex:i] valueForKey:ENG_NM]])
            {
                //把每一行按列切分开
                NSArray *test = [[assList objectAtIndex:j]componentsSeparatedByString:@"\t"];
                for (int k=0; k<test.count; k++) {
                    NSString *string_k = [test objectAtIndex:k];
                    NSLog(@"k=%d, %@",k,string_k);
                    //单个字段有可能因为ocr有误差导致有空格，所以先去掉
                    string_k = [[test objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    //寻找测定值
                    //把该行的每列拿出来看看，是否能转成数字，一般来讲第一个数字就是就是测定值，但不排除有出现多个数字的可能(比如ocr把向上向下箭头解读返回1)
                    //理论上来讲只要这个是数字一般都会是"测定值"这个属性，注意trim掉空格防止ocr本身解析误差
                    if([self isNumber:string_k]){
                        //测定值已经有了
                        if([result_dict valueForKey:VALUE] != nil){
                            //新的值不是1，即不是ocr将箭头误解为1，那么认为新的数字才是测定值
                            if([string_k floatValue] != 1){
                                //a.setCeding(Float.parseFloat(test[j]));
                                [result_dict setValue:string_k forKey:VALUE];
                            }
                        }else{
                            //如果是数字那么认为找到了这个检查项的测定值
                            [result_dict setValue:string_k forKey:VALUE];
                        }
                    }
                    
                    //寻找参考范围
                    //通常认为参考范围也是至少是在第三个位置以后
                    if (k>=2) {
                        //判断是不是上下限，通过"-"连接的，如20-70
                        //if ([string_k containsString:@"-"])
                        if ([self containString:string_k contains:@"-"])
                        {
                            NSArray *array = [string_k componentsSeparatedByString:@"-"];
                            if (array!=nil && array.count>=2) {
                                [result_dict setValue:[array objectAtIndex:0] forKey:REF_LOW];
                                [result_dict setValue:[array objectAtIndex:1] forKey:REF_HIGH];
                            }
                        }
                        //也有可能是通过"~"关联，如20~70
                        //if ([string_k containsString:@"~"])
                        if ([self containString:string_k contains:@"~"])
                        {
                            NSArray *array = [string_k componentsSeparatedByString:@"~"];
                            if (array!=nil && array.count>=2) {
                                [result_dict setValue:[array objectAtIndex:0] forKey:REF_LOW];
                                [result_dict setValue:[array objectAtIndex:1] forKey:REF_HIGH];
                            }
                        }
                        //也有可能是>如>20，变成20-10000
                        //if ([string_k containsString:@">"])
                        if ([self containString:string_k contains:@">"])
                        {
                            NSArray *array = [string_k componentsSeparatedByString:@"~"];
                            if (array!=nil && array.count>=2) {
                                if ([array[0] isEqualToString:array[1]]) {
                                    [result_dict setValue:[array objectAtIndex:0] forKey:REF_LOW];
                                    [result_dict setValue:@"10000.0" forKey:REF_HIGH];
                                }else{
                                    [result_dict setValue:[array objectAtIndex:0] forKey:REF_LOW];
                                    [result_dict setValue:[array objectAtIndex:1] forKey:REF_HIGH];
                                }
                                
                            }
                        }
                    }// 寻找范围结束
                    
                    //寻找单位，一般单位在第三个位置以后，可能包含/ fL pg %等字符
                    //if (k>=2 && ([string_k containsString:@"/"] || [string_k containsString:@"fL"] || [string_k containsString:@"pg"]))
                    if (k>=2 && (([self containString:string_k contains:@"/"])||([self containString:string_k contains:@"fL"])
                                 ||([self containString:string_k contains:@"pg"])))
                    {
                        [string_k stringByReplacingOccurrencesOfString:@"|" withString:@""];
                        [result_dict setValue:string_k forKey:UNIT];
                    }
                    
                }
                
                break;
            }// 找到了我们要的值
        } //for (int j=0; j<assList.count; j++)
        if ([result_dict valueForKey:UNIT] == nil) {
            NSLog(@"not found the unit,set default is g/l");
            [result_dict setValue:@"" forKey:UNIT];
        }
        [_assResultList addObject:result_dict];
        
    }
    NSLog(@"%@", _assResultList);
    
    [self updatePostArrayALL];
    
    NSLog(@"hello here");
}

- (Boolean)containString:(NSString *)orignal contains:(NSString*)string
{
    NSRange range = [orignal rangeOfString:string];
    if (range.location != NSNotFound) {
        return true;
    }
    if (range.length > 0) {
        return true;
    }else{
        return false;
    }
    return false;
}

- (Boolean)isNumber:(NSString *)string
{
    if( ![self isPureInt:string] || ![self isPureFloat:string])
    {
        NSLog(@"not number!");
        return false;
    }else
    {
        NSLog(@"is number");
        return true;
    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    //return[scan scanInt:&val] && [scan isAtEnd];
    //if ([string containsString:@"-"] || [string containsString:@"~"])
    if ([self  containString:string contains:@"-"]||[self containString:string contains:@"~"])
    {
        return false;
    }
    return [scan scanInt:&val];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    //return[scan scanFloat:&val] && [scan isAtEnd];
    //if ([string containsString:@"-"] || [string containsString:@"~"])
    if ([self containString:string contains:@"-"] || [self containString:string contains:@"~"])
    {
        return false;
    }
    return [scan scanFloat:&val];
}

- (void)viewDidAppear:(BOOL)animated
{
//    _label.text = @"Loading image...";
//    Client *client = [[Client alloc] initWithApplicationID:MyApplicationID password:MyPassword];
//	[client setDelegate:self];
//	
//	if([[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"] == nil) {
//		NSString* deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//		
//		NSLog(@"First run: obtaining installation ID..");
//		NSString* installationID = [client activateNewInstallation:deviceID];
//		NSLog(@"Done. Installation ID is \"%@\"", installationID);
//		
//		[[NSUserDefaults standardUserDefaults] setValue:installationID forKey:@"installationID"];
//	}
//	
//	NSString* installationID = [[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"];
//	
//	client.applicationID = [client.applicationID stringByAppendingString:installationID];
//	
//	ProcessingParams* params = [[ProcessingParams alloc] init];
//	
//	[client processImage:_image withParams:params];
//	
//	_label.text = @"Uploading image...";
    _ocrTableView.hidden = NO;
	
    [super viewDidAppear:animated];
    
}

#pragma mark - ClientDelegate implementation

- (void)clientDidFinishUpload:(Client *)sender
{
	_label.text = @"Processing image...";
}

- (void)clientDidFinishProcessing:(Client *)sender
{
	_label.text = @"Downloading result...";
}

- (void)client:(Client *)sender didFinishDownloadData:(NSData *)downloadedData
{
	_label.hidden = YES;
    _label.text = @"Loading image...";
	//statusIndicator.hidden = YES;
	
	_textView.hidden = NO;
	
	NSString* result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	
	_textView.text = result;
    NSLog(@"result = %@", result);
}

- (void)client:(Client *)sender didFailedWithError:(NSError *)error
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[error localizedDescription]
												   delegate:nil
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:nil, nil];
	
	[alert show];
	
	_label.text = [error localizedDescription];
	//statusIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(UIBarButtonItem *)sender {
    
    NSLog(@"confirming...");
    [self.view endEditing:YES];
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultForApp:_checkItemId checkItemIds:_postArray];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)_dataList.count);
    
    PandaOCRResultViewController *ocrResultViewController = [[PandaOCRResultViewController alloc]initWithNibName:nil bundle:nil];
    ocrResultViewController.postArray = _postArray;
    ocrResultViewController.checkItemId = _checkItemId;
    ocrResultViewController.data = data;
    
    [self.navigationController pushViewController:ocrResultViewController animated:YES];
    
}

- (IBAction)confirmByBtn:(UIButton *)sender {
    
    NSLog(@"confirming...");
    [self.view endEditing:YES];
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultForApp:_checkItemId checkItemIds:_postArray];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)_dataList.count);
    
    PandaOCRResultViewController *ocrResultViewController = [[PandaOCRResultViewController alloc]initWithNibName:nil bundle:nil];
    ocrResultViewController.postArray = _postArray;
    ocrResultViewController.checkItemId = _checkItemId;
    ocrResultViewController.data = data;
    
    [self.navigationController pushViewController:ocrResultViewController animated:YES];
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//mark for pandaUITextField

- (void)textFieldDidBeginEditing:(PandaUITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y+32 - (self.view.frame.size.height - 250.0);//键盘高度250
    NSTimeInterval animationDuration = 0.30f;
    offset = 100;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(PandaUITextField *)textField
{
    NSLog(@"textFieldDidEndEditing, %d : value = %@", textField.mid,textField.text);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.mid inSection:0];
    PandaOCRTableViewCell *cell = [_ocrTableView cellForRowAtIndexPath:indexPath];
    NSLog(@"value = %@, high = %@, low = %@",cell.OCR_value.text, cell.REF_high.text, cell.REF_low.text);
    
    //update _assResultList
    [self updateAssResultList:textField.mid value:cell.OCR_value.text refLow:cell.REF_low.text refHight:cell.REF_high.text unit:cell.OCR_unit.text];
    //update _postArray
    [self updatePostArray:textField.mid value:cell.OCR_value.text refLow:cell.REF_low.text refHight:cell.REF_high.text];
    [_ocrTableView reloadData];
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)updateAssResultList:(NSInteger)index value:(NSString *)value refLow:(NSString *)low refHight:(NSString *)high unit:(NSString*)unit
{
    NSDictionary *dict = [_assResultList objectAtIndex:index];
    [dict setValue:value forKey:VALUE];
    [dict setValue:low forKey:REF_LOW];
    [dict setValue:high forKey:REF_HIGH];
    [dict setValue:unit forKey:UNIT];
    [_assResultList replaceObjectAtIndex:index withObject:dict];
}

- (void)updatePostArray:(NSInteger)index value:(NSString *)value refLow:(NSString *)low refHight:(NSString *)high
{
    NSDictionary *dict = [_postArray objectAtIndex:index];

    // 首先判断是否为空
    if (value == nil || low == nil || high == nil) {
        [dict setValue:@"0" forKey:RESULT]; // 如果value / low / high 任何一样是nil, 表示用户不想输入什么值, 那么认为该项是正常的
        return;
    }
    
    // 再次, 过滤空格
    [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    [low stringByReplacingOccurrencesOfString:@" " withString:@""];
    [high stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (value == @"" || low == @"" || high == @"") // 任何一项是空值
    {
        [dict setValue:@"0" forKey:RESULT];
        return;
    }
    
    float value_f = [value floatValue];
    float low_f   = [low floatValue];
    float high_f  = [high floatValue];
    if (value_f<low_f) {
        [dict setValue:@"3" forKey:RESULT]; // 偏低
    }else if (value_f > high_f)
    {
        [dict setValue:@"1" forKey:RESULT];
    }else if (value_f >= low_f && value_f<=high_f)
    {
        [dict setValue:@"0" forKey:RESULT];
    }else //any other value
    {
        [dict setValue:@"0" forKey:RESULT];
    }
}

- (void)updatePostArrayALL
{
    for (int i=0; i<_assResultList.count; i++) {
        NSDictionary *dict = [_assResultList objectAtIndex:i];
        NSString *value = [dict valueForKey:VALUE];
        NSString *low  = [dict  valueForKey:REF_LOW];
        NSString *high = [dict valueForKey:REF_HIGH];
        
        [self updatePostArray:i value:value refLow:low refHight:high];
    }
}

- (BOOL)textField:(PandaUITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"shouldChangeCharactersInRange, value now is %d: %@",textField.mid, textField.text);
    return YES;
}

- (IBAction)touchDown:(UIControl *)sender {
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return _assResultList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (PandaOCRTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"cell";
    PandaOCRTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PandaOCRTableViewCell" owner:self options:nil] objectAtIndex:0];
    NSDictionary *dict = [_assResultList objectAtIndex:indexPath.row];
    cell.OCR_name.text = [dict valueForKey:ITEM_NM];
    cell.OCR_unit.text = [dict valueForKey:UNIT];
    cell.OCR_unit.mid = indexPath.row;
    cell.OCR_unit.delegate = self;
    cell.REF_low.text = [dict valueForKey:REF_LOW];
    cell.REF_low.mid = indexPath.row;
    cell.REF_low.delegate = self;
    cell.REF_high.text = [dict valueForKey:REF_HIGH];
    cell.REF_high.mid = indexPath.row;
    cell.REF_high.delegate = self;
    cell.OCR_value.text = [dict valueForKey:VALUE];
    cell.OCR_value.mid = indexPath.row;
    cell.OCR_value.delegate = self;
    [self.view endEditing:YES]; // 只要listview 发生滑动 , 立刻取消输入
    NSLog(@"index = %d", indexPath.row);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


@end
