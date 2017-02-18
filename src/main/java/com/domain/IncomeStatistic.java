package com.domain;

import java.util.Date;

/**
 * 收入统计
 * @author zhenjunzhuo
 * 2016-11-15
 */
public class IncomeStatistic {
	// 日期
    private Date date;
    // 总数
    private Integer total;
    // 金额
    private Double totalPrice;

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

   
}