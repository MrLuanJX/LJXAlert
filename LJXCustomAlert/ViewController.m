//
//  ViewController.m
//  LJXCustomAlert
//
//  Created by 栾金鑫 on 2019/8/28.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "ViewController.h"
#import "LJXAlertView.h"

@interface ViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTable];
}

- (void) setupTable {
    [self.view addSubview: self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID = @"cellId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [LJXAlertView showWithAlertWithType:(NSInteger)indexPath.row title:@"提示" titleBackgroundColor:[UIColor lightGrayColor] content:@"上海市浦东新区消保委：不接受调解，上海迪士尼坚持翻包检查】上海迪士尼乐园禁带食物且翻包检查引发的舆论风暴仍在发酵。美国迪士尼乐园总部公共事务部和上海市浦东新区消费者权益保护委员会近两日相继做出回应。前者称他们无法回复关于上海迪士尼的问题，后者称上海迪士尼不接受调解，不会就禁带食物、翻包检查等规定做更改。中国消费者协会专家指出，相关监管部门不能缺位，应按照法律规定进行调查。（人民网）上海市浦东新区消保委：不接受调解，上海迪士尼坚持翻包检查】上海迪士尼乐园禁带食物且翻包检查引发的舆论风暴仍在发酵。美国迪士尼乐园总部公共事务部和上海市浦东新区消费者权益保护委员会近两日相继做出回应。前者称他们无法回复关于上海迪士尼的问题，后者称上海迪士尼不接受调解，不会就禁带食物、翻包检查等规定做更改。中国消费者协会专家指出，相关监管部门不能缺位，应按照法律规定进行调查。（人民网）"  cancelBtnTitle:@"取消" resultBtnTitle:@"确定" otherResultBtnTitle:@"" cancelBtnBackColor:[UIColor whiteColor] resultBtnBackColor:[UIColor orangeColor] otherResultBtnBackColor:[UIColor purpleColor] cancelBlock:^{
        NSLog(@"取消");
    } resultBlock:^{
        NSLog(@"确定");
    } otherResultBlock:^{
        NSLog(@"其他");
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"singleBtn",@"doubleBtn",@"threeBtn", nil];
    }
    return _dataSource;
}



@end
