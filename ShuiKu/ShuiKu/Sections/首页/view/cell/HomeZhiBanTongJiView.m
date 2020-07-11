
//
//  HomeZhiBanTongJiView.m
//  ShuiKu
//
//  Created by Mac on 2020/7/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeZhiBanTongJiView.h"
#import "RiLiZhouCollectionViewCell.h"
#import "RiLiDayCollectionViewCell.h"


@interface HomeZhiBanTongJiView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , retain) UILabel *lbtime;
///今日
@property (nonatomic , retain) NSDate *todayDate;

@property (nonatomic , retain) UICollectionView *colleView;
///日历数据
@property (nonatomic , retain) NSArray *arrMone;
@property (nonatomic , strong) NSDate *date;
///当前选中的日
@property (nonatomic , assign) NSInteger inowdate;
@property (nonatomic , assign) NSInteger inowTodaydate;
@end

@implementation HomeZhiBanTongJiView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        _date = [NSDate date];
        _todayDate = [NSDate date];
        _inowdate = [self day:_date];
        _inowTodaydate = _inowdate;
        _arrMone = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"未值班统计"];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:16]];
        [lbtitle setTextColor:MenuColor];
        [self addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.top.offset(0);
            make.height.offset(40);
        }];
        
        UIButton *btmore = [[UIButton alloc] init];
        [btmore setTitle:@"回到今日" forState:UIControlStateNormal];
        [btmore setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [btmore.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btmore.layer setMasksToBounds:YES];
        [btmore.layer setCornerRadius:3];
        [btmore.layer setBorderColor:RGB(100, 100, 100).CGColor];
        [btmore.layer setBorderWidth:1];
        [self addSubview:btmore];
        [btmore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(70, 25));
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(lbtitle);
        }];
        [btmore addTarget:self action:@selector(moreActon) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btlast = [[UIButton alloc] init];
        [btlast setImage:[UIImage imageNamed:@"上一步"] forState:UIControlStateNormal];
        [self addSubview:btlast];
        [btlast mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(lbtitle.mas_bottom);
            make.height.offset(50);
            make.width.offset(30);
        }];
        [btlast setTag:0];
        [btlast addTarget:self action:@selector(timeMouthAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnext = [[UIButton alloc] init];
        [btnext setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
        [self addSubview:btnext];
        [btnext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.size.centerY.equalTo(btlast);
        }];
        [btnext setTag:1];
        [btnext addTarget:self action:@selector(timeMouthAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setText:@""];
        [lbtime setTextAlignment:NSTextAlignmentCenter];
        [lbtime setFont:[UIFont systemFontOfSize:16]];
        [lbtime setTextColor:RGB(80, 80, 80)];
        [self addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.centerY.equalTo(btlast);
            make.centerX.equalTo(self);
        }];
        _lbtime = lbtime;
        NSString *strtime = [self strTimefromDatas:_date dataFormat:@"yyyy年MM月"];
        [_lbtime setText:strtime];
        
        
        float fitem = (kMainScreenW-30)/9.2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(fitem, fitem)];
        UICollectionView *colleView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [colleView setDelegate:self];
        [colleView setDataSource:self];
        [colleView setBackgroundColor:[UIColor whiteColor]];
        [colleView setScrollEnabled:NO];
        [self addSubview:colleView];
        [colleView registerClass:[RiLiZhouCollectionViewCell class] forCellWithReuseIdentifier:@"RiLiZhouCollectionViewCell"];
        [colleView registerClass:[RiLiDayCollectionViewCell class] forCellWithReuseIdentifier:@"RiLiDayCollectionViewCell"];
        _colleView = colleView;
        
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger ialldate = daysInThisMonth+firstWeekday-1;
        NSInteger ilne = ialldate/7;
        if(ialldate%7!=0)
        {
            ilne+=1;
        }
        [colleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(btnext.mas_bottom).offset(10);
            make.height.offset(50*ilne);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(colleView.mas_bottom);
        }];
        
        
    }
    return self;
}

//当前日
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//第几月
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

//年份
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

//这个月的第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
//这个月有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

-(NSString *)strTimefromDatas:(NSDate *)times dataFormat:(NSString *)dataFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (dataFormat) {
        [dateFormatter setDateFormat:dataFormat];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return  [dateFormatter stringFromDate:times];
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr dataFormat:(NSString *)dataFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (dataFormat) {
        [dateFormatter setDateFormat:dataFormat];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

#pragma mark - 回到今日
-(void)moreActon
{
    
    
    _date = [NSDate date];
    NSString *strtime = [self strTimefromDatas:_date dataFormat:@"yyyy年MM月"];
    [_lbtime setText:strtime];
    
    _inowTodaydate = [self day:_todayDate];
    NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
    
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger ialldate = daysInThisMonth+firstWeekday-1;
    NSInteger ilne = ialldate/7;
    if(ialldate%7!=0)
    {
        ilne+=1;
    }
    [_colleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(50*ilne);
    }];
    [_colleView reloadData];
}

#pragma mark - 上一步 下一步
-(void)timeMouthAction:(UIButton *)sender
{
    NSString *strtime = _lbtime.text;
    strtime = [strtime stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    strtime = [strtime stringByReplacingOccurrencesOfString:@"月" withString:@""];
    NSArray *arrtime = [strtime componentsSeparatedByString:@"-"];
    NSInteger year = [arrtime[0] integerValue];
    NSInteger mouth = [arrtime[1] integerValue];
    if(sender.tag==0)
    {
        if(mouth==1)
        {
            mouth=12;
            year-=1;
        }
        else
        {
            mouth-=1;
        }
    }
    else
    {
        if(mouth==12)
        {
            mouth=1;
            year+=1;
        }
        else
        {
            mouth+=1;
        }
    }
    NSString *strnowtime = [NSString stringWithFormat:@"%ld年%ld月",year,mouth];
    if(mouth<10)
    {
        strnowtime = [NSString stringWithFormat:@"%ld年0%ld月",year,mouth];
    }
    [_lbtime setText:strnowtime];
    _date = [self nsstringConversionNSDate:strnowtime dataFormat:@"yyyy年MM月"];
    
    _inowTodaydate = -1;
    ///
    NSString *strtemp = [self strTimefromDatas:[NSDate date] dataFormat:@"yyyy年MM月"];
    if([strtemp isEqualToString:strnowtime])
    {
        _inowTodaydate = [self day:_todayDate];
    }
    
    NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
    
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger ialldate = daysInThisMonth+firstWeekday-1;
    NSInteger ilne = ialldate/7;
    if(ialldate%7!=0)
    {
        ilne+=1;
    }
    [_colleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(50*ilne);
    }];
    [_colleView reloadData];
    
    
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 7;
    }
    else
    {
        return 42;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        RiLiZhouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RiLiZhouCollectionViewCell" forIndexPath:indexPath];
        cell.valueday = _arrMone[indexPath.row];
        [cell setBackgroundColor:[UIColor whiteColor]];
        return cell;
    }
    else if (indexPath.section==1)
    {///
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        RiLiDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RiLiDayCollectionViewCell" forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        if (i < firstWeekday) {
            cell.valueday = @"";
            cell.isselect = NO;
        }else if (i > firstWeekday + daysInThisMonth - 1){
            cell.valueday = @"";
            cell.isselect = NO;
        }else{
            day = i - firstWeekday + 1;
            cell.valueday = [NSString stringWithFormat:@"%li",(long)day];
            
            if(day == _inowdate)
            {
                cell.isselect = YES;
                
            }
            else
            {
                
                cell.isselect = NO;
            }
            
            if(day == _inowTodaydate)
            {
                cell.istoday = YES;
            }
            else
            {
                cell.istoday = NO;
            }
            
            
        }
        return cell;
    }
    
    return nil;;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    
    if (i < firstWeekday) {
               
   }else if (i > firstWeekday + daysInThisMonth - 1){
       
   }else{
       day = i - firstWeekday + 1;
       _inowdate = day;
   }
    [collectionView reloadData];
    
    
}



@end
