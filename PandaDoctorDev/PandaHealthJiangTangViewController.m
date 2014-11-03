//
//  PandaHealthJiangTangViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHealthJiangTangViewController.h"
#import "PandaRPCInterface.h"

#define REFRESH_HEADER_HEIGHT 52.0f



@interface PandaHealthJiangTangViewController ()

@end

@implementation PandaHealthJiangTangViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    // Do any additional setup after loading the view.
    NSLog(@"PandaHealthJiangTangViewController view did load");
    _itemList = [[NSArray alloc]initWithObjects:@"tech",@"cure",@"expert",@"life",@"news", nil];
    [self.navigationController.navigationBar setHidden:YES];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tech = [[NSMutableArray alloc]initWithCapacity:3];
    _cure = [[NSMutableArray alloc]initWithCapacity:3];
    _expert = [[NSMutableArray alloc]initWithCapacity:3];
    _life = [[NSMutableArray alloc]initWithCapacity:3];
    _news = [[NSMutableArray alloc]initWithCapacity:3];
    
    PandaRPCInterface *rpc = [[PandaRPCInterface alloc]init];
    //NSMutableData *data = [rpc getAllAriticle];
    NSMutableData *data = [rpc getAllAriticleByType:[_itemList objectAtIndex:0]];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _articleList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)_articleList.count);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articleList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"cell";
//    if (indexPath.row == 0) {
//        ScrollTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ScrollTableViewCell" owner:self options:nil] objectAtIndex:0];
//        return cell;
//    }else{
    
    PandaShareTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaShareTableViewCell" owner:self options:nil] objectAtIndex:0];
    NSDictionary *dict = [_articleList objectAtIndex:indexPath.row];
    cell.titleLabel.text = [dict valueForKey:TITLE];
    cell.author.text = [[_articleList objectAtIndex:indexPath.row] valueForKey:AUTHOR];
    cell.date.text = [[[_articleList objectAtIndex:indexPath.row] valueForKey:GMTMODIFY] componentsSeparatedByString:@"T"][0];
    NSString *url = [[_articleList objectAtIndex:indexPath.row] valueForKey:URL];
    NSMutableArray *array = [self getCurrentArray];
    if (cell.headerImage.image == nil) {
        NSLog(@"image is nil");
        if (url != nil) {
            if (array.count != nil && array.count > indexPath.row) { // 表明, 缓存里面, 有对应的图片.
                NSData *imageData = (NSData*)[array objectAtIndex:indexPath.row];
                [cell.headerImage setImage:imageData];
                return cell;
            }
            NSLog(@"%@",url);
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image=[[UIImage alloc] initWithData:imageData];
            [cell.headerImage setImage:image];
            [array addObject:image];
//            switch (_switchSegment.selectedSegmentIndex) {
//                case 0:
//                    [_tech addObjectsFromArray:imageData];
//                    break;
//                case 1:
//                    [_cure addObjectsFromArray:imageData];
//                    break;
//                case 2:
//                    [_expert addObjectsFromArray:imageData];
//                    break;
//                case 3:
//                    [_life addObjectsFromArray:imageData];
//                    break;
//                case 4:
//                    [_news addObjectsFromArray:imageData];
//                    break;
//                default:
//                    break;
//            }
        }else{
            [cell.headerImage setImage:[UIImage imageNamed:@"1.pic.jpg"]];
            [array addObject:[NSString stringWithFormat:@"%d", _switchSegment.selectedSegmentIndex]];
//            switch (_switchSegment.selectedSegmentIndex) {
//                case 0:
//                    [_tech addObjectsFromArray:@"0"];
//                    break;
//                case 1:
//                    [_cure addObjectsFromArray:@"1"];
//                    break;
//                case 2:
//                    [_expert addObjectsFromArray:@"2"];
//                    break;
//                case 3:
//                    [_life addObjectsFromArray:@"3"];
//                    break;
//                case 4:
//                    [_news addObjectsFromArray:@"4"];
//                    break;
//                default:
//                    break;
//            }
        }
    }
    
    return cell;
}

-(NSMutableArray *)getCurrentArray
{
    switch (_switchSegment.selectedSegmentIndex) {
        case 0:
            return _tech;
            break;
        case 1:
            return _cure;
            break;
        case 2:
            return _expert;
            break;
        case 3:
            return _life;
            break;
        case 4:
            return _news;
            break;
    }
    return  nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    NSLog(@"scrollview did end dragging");
    NSLog(@"%f", scrollView.contentOffset.y);
    NSLog(@"height = %f", scrollView.bounds.size.height);
    NSLog(@"%f", scrollView.contentInset.bottom);
    
    //上拉刷新
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT && scrollView.contentOffset.y > 0){
        NSLog(@"start update!");
    }
    
    //下拉刷新
    if (scrollView.contentOffset.y < -50) {
        NSLog(@"start update!");
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 65;
    }else{
        return 65;
    }
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"select cell %d", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _jiangtangDetailViewController = [[PandaHealthJiangTangDetailViewController alloc]initWithNibName:nil bundle:nil];
    _jiangtangDetailViewController.ariticle_id = [NSString stringWithFormat:@"%@", [[_articleList objectAtIndex:indexPath.row] valueForKey:ARTICLE_ID]];
    _jiangtangDetailViewController.titleString = [[_articleList objectAtIndex:indexPath.row] valueForKey:TITLE];
    _jiangtangDetailViewController.author = [[_articleList objectAtIndex:indexPath.row] valueForKey:AUTHOR];
    //_jiangtangDetailViewController.date = [[[_articleList objectAtIndex:indexPath.row] valueForKey:GMTMODIFY] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _jiangtangDetailViewController.date = [[[_articleList objectAtIndex:indexPath.row] valueForKey:GMTMODIFY] componentsSeparatedByString:@"T"][0];
    _jiangtangDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_jiangtangDetailViewController animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)switchArticle:(UISegmentedControl *)sender {
    
    NSLog(@"%d", sender.selectedSegmentIndex);
    PandaRPCInterface *rpc = [[PandaRPCInterface alloc]init];
    //NSMutableData *data = [rpc getAllAriticle];
    NSMutableData *data = [rpc getAllAriticleByType:[_itemList objectAtIndex:sender.selectedSegmentIndex]];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _articleList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [_tableView reloadData];
    NSLog(@"%lu", (unsigned long)_articleList.count);
    
}
@end
