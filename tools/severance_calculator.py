#!/usr/bin/env python3
"""
匈牙利离职赔偿金计算器
Hungary Severance Pay Calculator
"""

def calculate_severance(monthly_salary_huf, years_worked, months_worked=0):
    """
    计算离职赔偿金
    
    参数:
        monthly_salary_huf: 月平均工资（福林）
        years_worked: 完整工作年数
        months_worked: 额外工作月数（不满一年部分）
    
    返回:
        dict: 包含计算详情和结果
    """
    
    # 总工作年限（含小数）
    total_years = years_worked + (months_worked / 12)
    
    # 赔偿月数表
    severance_months_table = [
        (0, 3, 0),
        (3, 5, 1),
        (5, 10, 2),
        (10, 15, 3),
        (15, 20, 4),
        (20, 25, 5),
        (25, float('inf'), 6)
    ]
    
    # 查找对应赔偿月数
    severance_months = 0
    for min_years, max_years, months in severance_months_table:
        if min_years <= total_years < max_years:
            severance_months = months
            break
    
    # 计算赔偿金
    severance_amount = monthly_salary_huf * severance_months
    
    # 2024 年上限：年薪的 6 倍（约 1800 万福林）
    # 注意：这是年度总收入的上限，不是月工资上限
    ANNUAL_SALARY_CAP = 18_000_000  # 福林/年
    
    # 计算员工的年度工资
    annual_salary = monthly_salary_huf * 12
    
    # 如果员工年薪超过上限，赔偿基数按上限计算
    if annual_salary > ANNUAL_SALARY_CAP:
        # 使用上限作为计算基数
        capped_monthly_salary = ANNUAL_SALARY_CAP / 12
        max_severance = capped_monthly_salary * severance_months
        is_capped = True
    else:
        # 正常计算，不受上限影响
        max_severance = severance_amount
        is_capped = False
    
    final_amount = min(severance_amount, max_severance)
    
    return {
        "monthly_salary": monthly_salary_huf,
        "total_years_worked": round(total_years, 2),
        "severance_months": severance_months,
        "calculated_amount": severance_amount,
        "is_capped": is_capped,
        "cap_amount": max_severance if is_capped else None,
        "final_amount": final_amount
    }


def calculate_notice_period(years_worked, is_probation=False):
    """
    计算辞职通知期
    
    参数:
        years_worked: 工作年数
        is_probation: 是否在试用期
    
    返回:
        int: 通知期天数
    """
    if is_probation:
        return 0  # 试用期无需通知期
    
    return 30  # 标准通知期 30 天


def calculate_unused_vacation_pay(daily_salary, unused_days):
    """
    计算未休年假补偿
    
    参数:
        daily_salary: 日工资
        unused_days: 未休年假天数
    
    返回:
        float: 补偿金额
    """
    return daily_salary * unused_days


def format_huf(amount):
    """格式化福林金额"""
    return f"{amount:,.0f} HUF".replace(",", " ")


def main():
    """交互式计算器"""
    print("=" * 60)
    print("匈牙利离职赔偿金计算器")
    print("Hungary Severance Pay Calculator")
    print("=" * 60)
    print()
    
    # 输入工作年限
    print("📅 工作年限信息")
    years = int(input("完整工作年数: "))
    months = int(input("额外工作月数（不满一年）: ") or "0")
    
    # 输入工资
    print()
    print("💰 工资信息")
    print("提示：使用过去 6 个月平均工资（含奖金、津贴）")
    salary = float(input("月平均工资 (HUF): "))
    
    # 计算
    result = calculate_severance(salary, years, months)
    
    # 输出结果
    print()
    print("=" * 60)
    print("📊 计算结果")
    print("=" * 60)
    print(f"工作年限: {result['total_years_worked']} 年")
    print(f"月平均工资: {format_huf(result['monthly_salary'])}")
    print(f"应得赔偿月数: {result['severance_months']} 个月")
    print()
    
    if result['severance_months'] == 0:
        print("⚠️ 工作不满 3 年，无法定赔偿")
    else:
        print(f"计算赔偿金: {format_huf(result['calculated_amount'])}")
        
        if result['is_capped']:
            print(f"⚠️ 超过法定上限 {format_huf(result['cap_amount'])}")
            print(f"实际赔偿金: {format_huf(result['final_amount'])}")
        else:
            print(f"✅ 最终赔偿金: {format_huf(result['final_amount'])}")
    
    print()
    print("=" * 60)
    print("📋 赔偿标准参考")
    print("=" * 60)
    print("3 年以下: 无赔偿")
    print("3-5 年:   1 个月工资")
    print("5-10 年:  2 个月工资")
    print("10-15 年: 3 个月工资")
    print("15-20 年: 4 个月工资")
    print("20-25 年: 5 个月工资")
    print("25 年以上: 6 个月工资")
    print()
    print("⚠️ 免责声明: 本计算器仅供参考，具体金额以法律规定和实际协商为准。")


if __name__ == "__main__":
    main()
