//
//  PGGDataStartAndEndPickView.m
//  ZHProperty
//
//  Created by Mac on 2020/7/16.
//  Copyright © 2020 yx. All rights reserved.
//

#import "PGGDataStartAndEndPickView.h"


#define M_WIDTH [UIScreen mainScreen].bounds.size.width
#define M_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PGGDataStartAndEndPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSArray *arrnowtime;
    
    
    NSMutableArray *arryear;
    NSMutableArray *arrmouth;
    NSMutableArray *arrday;
    NSMutableArray *arrhouar;
    NSMutableArray *arrmintes;
    
    NSString *stryear;
    NSString *strmouth;
    NSString *strday;
    NSString *strhouar;
    NSString *strmintes;
    
    NSMutableArray *arralltitlelb;
    
    
}


@property (nonatomic , retain) UIView *viewselect;

@property (nonatomic , retain) UIView *viewline1;

@property (nonatomic , retain) UIView *viewline2;

@property (nonatomic , retain) UIPickerView *pickview;

@property (nonatomic , retain) UILabel *lbyear;

@property (nonatomic , retain) UILabel *lbmouth;

@property (nonatomic , retain) UILabel *lbday;

@property (nonatomic , retain) UILabel *lbhouar;

@property (nonatomic , retain) UILabel *lbmintes;

@property (nonatomic , retain) UILabel *lbstarttime;
@property (nonatomic , retain) UILabel *lbendtime;
///是否编辑结束于
@property (nonatomic , assign) BOOL ischangeend;
///
@property (nonatomic , retain) UIImageView *imgvback;

@end

@implementation PGGDataStartAndEndPickView

@synthesize viewselect,pickview,viewline1,viewline2,lbday,lbyear,lbhouar,lbmouth,lbmintes;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        viewselect = [[UIView alloc]initWithFrame:CGRectZero];
        [viewselect setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:viewselect];
        [viewselect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(120);
        }];
        viewline1 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline1 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        [self addSubview:viewline1];
        [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(1);
        }];
        
        UIImageView *imgvback = [[UIImageView alloc] init];
        [imgvback setImage:[UIImage imageNamed:@"shijianxuanzhealterheader.jpg"]];
        [viewselect addSubview:imgvback];
        [imgvback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewselect);
            make.top.offset(40);
            make.height.offset(60);
        }];
        _imgvback = imgvback;
        [imgvback setUserInteractionEnabled:YES];
        UILabel *lbshiyu = [[UILabel alloc] init];
        [lbshiyu setText:@"开始于"];
        [lbshiyu setTextColor:RGB(135, 135, 135)];
        [lbshiyu setTextAlignment:NSTextAlignmentLeft];
        [lbshiyu setFont:[UIFont systemFontOfSize:12]];
        [imgvback addSubview:lbshiyu];
        [lbshiyu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.top.offset(10);
        }];
        NSString *strtime = [self getnowdata:@"yyyy.MM.dd"];
        UILabel *lbstarttime = [[UILabel alloc] init];
        [lbstarttime setText:strtime];
        [lbstarttime setTextColor:RGB(35, 35, 35)];
        [lbstarttime setTextAlignment:NSTextAlignmentLeft];
        [lbstarttime setFont:[UIFont systemFontOfSize:14]];
        [imgvback addSubview:lbstarttime];
        [lbstarttime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbshiyu);
            make.top.equalTo(lbshiyu.mas_bottom).offset(3);
        }];
        _lbstarttime = lbstarttime;
        
        
        UILabel *lbend = [[UILabel alloc] init];
        [lbend setText:@"结束于"];
        [lbend setTextColor:RGB(135, 135, 135)];
        [lbend setTextAlignment:NSTextAlignmentLeft];
        [lbend setFont:[UIFont systemFontOfSize:12]];
        [imgvback addSubview:lbend];
        [lbend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(M_WIDTH/2.0+30);
            make.top.offset(10);
        }];
        UILabel *lbendtime = [[UILabel alloc] init];
        [lbendtime setText:strtime];
        [lbendtime setTextColor:RGB(35, 35, 35)];
        [lbendtime setTextAlignment:NSTextAlignmentLeft];
        [lbendtime setFont:[UIFont systemFontOfSize:14]];
        [imgvback addSubview:lbendtime];
        [lbendtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbend);
            make.top.equalTo(lbend.mas_bottom).offset(3);
        }];
        _lbendtime = lbendtime;
        
        UIButton *btstart = [[UIButton alloc] init];
        [imgvback addSubview:btstart];
        [btstart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.bottom.equalTo(imgvback);
            make.width.offset(M_WIDTH/2.0);
        }];
        [btstart setTag:0];
        [btstart addTarget:self action:@selector(startchangeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btend = [[UIButton alloc] init];
        [imgvback addSubview:btend];
        [btend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(M_WIDTH/2.0);
            make.top.bottom.equalTo(imgvback);
            make.width.offset(M_WIDTH/2.0);
        }];
        [btend setTag:1];
        [btend addTarget:self action:@selector(startchangeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        viewline2 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline2 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        [self addSubview:viewline2];
        [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(viewselect.mas_bottom).offset(-1);
            make.height.offset(1);
        }];
        
        
        pickview = [[UIPickerView alloc]initWithFrame:CGRectZero];
        [pickview setDelegate:self];
        [pickview setDataSource:self];
        [pickview setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:pickview];
        [pickview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(viewselect.mas_bottom);
        }];
        
        
        arralltitlelb = [NSMutableArray new];
        
        lbyear = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbyear setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbyear setTextAlignment:NSTextAlignmentCenter];
        [lbyear setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbmouth = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbmouth setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbmouth setTextAlignment:NSTextAlignmentCenter];
        [lbmouth setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        
        lbday = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbday setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbday setTextAlignment:NSTextAlignmentCenter];
        [lbday setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbhouar = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbhouar setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbhouar setTextAlignment:NSTextAlignmentCenter];
        [lbhouar setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbmintes = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbmintes setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbmintes setTextAlignment:NSTextAlignmentCenter];
        [lbmintes setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        [arralltitlelb addObject:lbyear];
        [arralltitlelb addObject:lbmouth];
        [arralltitlelb addObject:lbday];
        [arralltitlelb addObject:lbhouar];
        [arralltitlelb addObject:lbmintes];
        
        
        UIButton *btok = [[UIButton alloc] init];
        [btok setTitle:@"确定" forState:UIControlStateNormal];
        [btok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btok.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [viewselect addSubview:btok];
        [btok addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [btok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.offset(10);
            make.width.offset(60);
            make.height.offset(30);
        }];
        
        UIButton *btcancle = [[UIButton alloc] initWithFrame:CGRectMake(btok.right + 20, btok.top, btok.width, btok.height)];
        [btcancle setTitle:@"取消" forState:UIControlStateNormal];
        [btcancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btcancle.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [viewselect addSubview:btcancle];
        [btcancle addTarget:self action:@selector(dismisself) forControlEvents:UIControlEventTouchUpInside];
        [btcancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btok);
            make.size.equalTo(btok);
            make.right.equalTo(viewselect).offset(-20);
        }];
        
        
        
    }
    return self;
}
-(void)getdata
{
    arryear = [NSMutableArray new];
    arrmouth = [NSMutableArray new];
    arrday = [NSMutableArray new];
    arrhouar = [NSMutableArray new];
    arrmintes = [NSMutableArray new];
    
    NSString *strnowtime = [self getnowdata:@"yyyy-MM-dd HH:mm:ss"];
    strnowtime = [strnowtime stringByReplacingOccurrencesOfString:@" " withString:@":"];
    strnowtime = [strnowtime stringByReplacingOccurrencesOfString:@"-" withString:@":"];
    arrnowtime = [strnowtime componentsSeparatedByString:@":"];
    
    stryear = arrnowtime[0];
    strmouth= arrnowtime[1];
    strday= arrnowtime[2];
    strhouar= arrnowtime[3];
    strmintes= arrnowtime[4];
    if(_isNotnowtime == YES)
    {
        for(int i = 1949;i<=[arrnowtime[0] intValue]+20;i++)
        {
            
            [arryear addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for(int j = 1;j<=12;j++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 1;j<=31;j++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<24;j++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=60;j++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    else
    {
        for(int i = 1949;i<=[arrnowtime[0] intValue];i++)
        {
            
            [arryear addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for(int j = 1;j<=[arrnowtime[1] intValue];j++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 1;j<=[arrnowtime[2] intValue];j++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=[arrnowtime[3] intValue];j++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=[arrnowtime[4] intValue];j++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    
}


-(void)setIline:(int)iline
{
    [self getdata];
    _iline = iline;
    NSArray *arrttemp = [NSArray arrayWithObjects:@"年",@"月",@"日",@"时",@"分", nil];
    for(int i = 0 ; i < _iline; i++)
    {
        UILabel *lb = arralltitlelb[i];
        [lb setText:arrttemp[i]];
        [viewselect addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(100);
            make.height.offset(20);
            make.left.offset(M_WIDTH/_iline*i);
            make.width.offset(M_WIDTH/_iline);
        }];
    }
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(selecttempaction) userInfo:nil repeats:NO];
}
///默认选中
-(void)selecttempaction
{
    if(_iline == 1)
    {
        [pickview selectRow:[self getnomoline:arryear andvalue:stryear] inComponent:0 animated:YES];
        
    }
    else if (_iline == 2)
    {
        [pickview selectRow:[self getnomoline:arryear andvalue:stryear] inComponent:0 animated:YES];
        [pickview selectRow:[self getnomoline:arrmouth andvalue:strmouth] inComponent:1 animated:YES];
    }
    else if (_iline == 3)
    {
        [pickview selectRow:[self getnomoline:arryear andvalue:stryear] inComponent:0 animated:YES];
        [pickview selectRow:[self getnomoline:arrmouth andvalue:strmouth] inComponent:1 animated:YES];
        [pickview selectRow:[self getnomoline:arrday andvalue:strday] inComponent:2 animated:YES];
        
    }
    else if (_iline == 4)
    {
        [pickview selectRow:[self getnomoline:arryear andvalue:stryear] inComponent:0 animated:YES];
        [pickview selectRow:[self getnomoline:arrmouth andvalue:strmouth] inComponent:1 animated:YES];
        [pickview selectRow:[self getnomoline:arrday andvalue:strday] inComponent:2 animated:YES];
        [pickview selectRow:[self getnomoline:arrhouar andvalue:strhouar] inComponent:3 animated:YES];
        
    }
    else if (_iline == 5)
    {
        [pickview selectRow:[self getnomoline:arryear andvalue:stryear] inComponent:0 animated:YES];
        [pickview selectRow:[self getnomoline:arrmouth andvalue:strmouth] inComponent:1 animated:YES];
        [pickview selectRow:[self getnomoline:arrday andvalue:strday] inComponent:2 animated:YES];
        [pickview selectRow:[self getnomoline:arrhouar andvalue:strhouar] inComponent:3 animated:YES];
        [pickview selectRow:[self getnomoline:arrmintes andvalue:strmintes] inComponent:4 animated:YES];
        
    }
    
}
-(NSInteger)getnomoline:(NSMutableArray *)arr andvalue:(NSString *)strnomo
{
    NSInteger i = 0;
    for(NSString *str in arr)
    {
        if([str intValue] == strnomo.intValue)
        {
            return i;
        }
        i++;
    }
    return 0;
}

-(void)okAction
{
    
//    if(_iline == 1)
//    {
//        [self.degelate changetimeValue:[NSString stringWithFormat:@"%@",stryear]];
//    }
//    else if (_iline == 2)
//    {
//
//        [self.degelate changetimeValue:[NSString stringWithFormat:@"%@-%@",stryear,strmouth]];
//    }
//    else if (_iline == 3)
//    {
//
//        [self.degelate changetimeValue:[NSString stringWithFormat:@"%@-%@-%@",stryear,strmouth,strday]];
//    }
//    else if (_iline == 4)
//    {
//
//        [self.degelate changetimeValue:[NSString stringWithFormat:@"%@-%@-%@ %@",stryear,strmouth,strday,strhouar]];
//    }
//    else if (_iline == 5)
//    {
//
//        [self.degelate changetimeValue:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",stryear,strmouth,strday,strhouar,strmintes]];
//    }
    NSString *strback = [NSString stringWithFormat:@"%@&%@",self.lbstarttime.text,self.lbendtime.text];
    strback = [strback stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    [self.degelate changetimeValue:strback];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self->viewselect setTop:M_HEIGHT];
        [self->pickview setTop:M_HEIGHT+self->viewselect.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)dismisself
{
    [self.degelate dismisAction];
    [UIView animateWithDuration:0.5 animations:^{
        [self->viewselect setTop:M_HEIGHT];
        [self->pickview setTop:M_HEIGHT+self->viewselect.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)startchangeAction:(UIButton *)sender
{
    if(sender.tag==1)
    {
        [_imgvback setImage:[UIImage imageNamed:@"shijianxuanzhealterheader.jpg"]];
        self.ischangeend = YES;
    }
    else
    {
        [_imgvback setImage:[UIImage imageNamed:@"shijianxuanzhealterheader.jpg"]];
        self.ischangeend = NO;
    }
    
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _iline;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return arryear.count;
    }
    else if(component == 1)
    {
        return arrmouth.count;
    }
    else if(component == 2)
    {
        return arrday.count;
    }
    else if(component == 3)
    {
        return arrhouar.count;
    }
    else if(component == 4)
    {
        return arrmintes.count;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    float fline = 5.2;
    if(_iline == 3)
    {
        fline = 3.2;
    }
    return pickerView.width/(_iline+0.2);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:( UIView *)view
{
    float fline = 5.2;
    if(_iline == 3)
    {
        fline = 3.2;
    }
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pickerView.width/(_iline+0.2), 40)];
    if(component == 0)
    {
        [lb setText:arryear[row]];
    }
    else if(component == 1)
    {
        [lb setText:arrmouth[row]];
    }
    else if(component == 2)
    {
        [lb setText:arrday[row]];
    }
    else if(component == 3)
    {
        [lb setText:arrhouar[row]];
    }
    else if(component == 4)
    {
        [lb setText:arrmintes[row]];
    }
    
    [lb setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setFont:[UIFont fontWithName:@"Arial" size:14]];
    return lb;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        stryear = arryear[row];
        
        [self yearjudge];
        [self mouthjudge];
        [self dayjudge];
        [self houarjudge];
        
        
        [pickerView reloadAllComponents];
        
    }
    else if(component == 1)
    {
        strmouth = arrmouth[row];
        
        [self mouthjudge];
        [self dayjudge];
        [self houarjudge];
        
        [pickerView reloadAllComponents];
        
    }
    else if(component == 2)
    {
     
        strday = arrday[row];
        
        [self dayjudge];
        [self houarjudge];
        
        [pickerView reloadAllComponents];
        
        
    }
    else if(component == 3)
    {
        
        strhouar = arrhouar[row];
        
        [self houarjudge];
        
        [pickerView reloadComponent:4];
        
    }
    else if(component == 4)
    {
        strmintes = arrmintes[row];
    }
    
    if([strmouth intValue] < 10)
    {
        strmouth = [NSString stringWithFormat:@"0%d",[strmouth intValue]];
    }
    if([strday intValue] < 10)
    {
        strday = [NSString stringWithFormat:@"0%d",[strday intValue]];
    }
    if([strhouar intValue] < 10)
    {
        strhouar = [NSString stringWithFormat:@"0%d",[strhouar intValue]];
    }
    if([strmintes intValue] < 10)
    {
        strmintes = [NSString stringWithFormat:@"0%d",[strmintes intValue]];
    }
    
    NSString *strvaluetemp = @"";
    if(_iline == 1)
    {
        strvaluetemp = stryear;
    }
    else if (_iline == 2)
    {
        strvaluetemp = [NSString stringWithFormat:@"%@.%@",stryear,strmouth];
    }
    else if (_iline == 3)
    {
        strvaluetemp = [NSString stringWithFormat:@"%@.%@.%@",stryear,strmouth,strday];
    }
    else if (_iline == 4)
    {
        strvaluetemp = [NSString stringWithFormat:@"%@.%@.%@ %@",stryear,strmouth,strday,strhouar];
    }
    else if (_iline == 5)
    {
        strvaluetemp = [NSString stringWithFormat:@"%@.%@.%@ %@:%@",stryear,strmouth,strday,strhouar,strmintes];
    }
    
    
    if(self.ischangeend)
    {
        [self.lbendtime setText:strvaluetemp];
    }
    else
    {
        [self.lbstarttime setText:strvaluetemp];
    }
    
    
}

-(void)yearjudge
{
    if(_isNotnowtime == YES)
    {
        arrmouth = [NSMutableArray new];
        for(int i =1; i <= 12;i++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        if([stryear intValue] == [arrnowtime[0]intValue])
        {
            arrmouth = [NSMutableArray new];
            for(int i =1; i <= [arrnowtime[1] intValue];i++)
            {
                [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
            }
            if([strmouth intValue] > [arrnowtime[1] intValue])
            {
                strmouth =arrnowtime[1];
            }
            [self mouthjudge];
            
        }
        else
        {
            arrmouth = [NSMutableArray new];
            for(int i =1; i <= 12;i++)
            {
                [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
    
}

-(void)mouthjudge
{
    if(_isNotnowtime == YES)
    {
        arrday = [NSMutableArray new];
        for(int i =1; i <= [self countday:stryear andmouth:strmouth];i++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        if([strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
        {
            arrday = [NSMutableArray new];
            for(int i =1; i <= [arrnowtime[2] intValue];i++)
            {
                [arrday addObject:[NSString stringWithFormat:@"%d",i]];
            }
            if([strday intValue] > [arrnowtime[2] intValue])
            {
                strday =arrnowtime[2];
            }
            
            [self dayjudge];
        }
        else
        {
            arrday = [NSMutableArray new];
            for(int i =1; i <= [self countday:stryear andmouth:strmouth];i++)
            {
                [arrday addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
}

-(void)dayjudge
{
    
    if([strday intValue] == [arrnowtime[2]intValue]&&[strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
    {
        arrhouar = [NSMutableArray new];
        for(int i =0; i <= [arrnowtime[3] intValue];i++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",i]];
        }
        if([strhouar intValue] > [arrnowtime[3] intValue])
        {
            strhouar =arrnowtime[3];
        }
        [self houarjudge];
    }
    else
    {
        arrhouar = [NSMutableArray new];
        for(int i =0; i <= 23;i++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
}

-(void)houarjudge
{
    
    if([strhouar intValue] == [arrnowtime[3]intValue]&&[strday intValue] == [arrnowtime[2]intValue]&&[strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
    {
        arrmintes = [NSMutableArray new];
        for(int i =0; i <= [arrnowtime[4] intValue];i++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        arrmintes = [NSMutableArray new];
        for(int i =0; i <= 59;i++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
}

#pragma mark - 根据年和月  返回当前月的天数
-(int)countday:(NSString *)year andmouth:(NSString *)mouth
{
    NSMutableArray *arrdata = [[NSMutableArray alloc]initWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    if([year intValue]%4 == 0)
    {
        if([year intValue]%100 == 0)
        {
            if([year intValue]%400 == 0)
            {
                arrdata[1] = @"29";
            }
            else
            {
                arrdata[1] = @"28";
            }
            
        }
        else
        {
            arrdata[1] = @"29";
        }
        
    }
    else
    {
        arrdata[1] = @"28";
    }
    return [arrdata[[mouth intValue]-1] intValue];
}

///获取当前时间 yyyy-MM-dd HH:mm:ss
-(NSString *)getnowdata:(NSString *)strtype
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:strtype];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT-0500"];
    [formatter setTimeZone:timeZone];
    NSDate *data = [NSDate date];
    NSString *str = [formatter stringFromDate:data];
    return str;
}


@end
