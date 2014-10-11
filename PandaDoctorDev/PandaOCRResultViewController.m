//
//  PandaOCRResultViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/10/1.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaOCRResultViewController.h"
#import "PandaRPCInterface.h"

@interface PandaOCRResultViewController ()

@end

@implementation PandaOCRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //_resultTextView.text = _datastr;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *ind_result_dict = [dict valueForKey:IND_RESULT];
    
    NSMutableString *show_result = [[NSMutableString alloc]initWithCapacity:3];
    
    for (int i=0; i<ind_result_dict.count; i++) {
        NSDictionary *dict = [ind_result_dict objectAtIndex:i];
        NSString *strTemp = [NSString stringWithFormat:@"%d. %@\r\n\r\n",i+1,[dict valueForKey:RST_DESC]];
        [show_result appendString:strTemp];
    }
    
    
    
    _resultTextView.text = show_result;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveResult:(UIBarButtonItem *)sender {
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
