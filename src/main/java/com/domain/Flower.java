package com.domain;

import java.util.Date;

/**
 * 花
 * @author zhenjunzhuo
 * 2016-10-31
 */
public class Flower {
	
    private Long id;
    // 名称
    private String name;
    // 图片
    private String pic;
    // 价格
    private Double price;
    // 是否展示，Y：是，N：否
    private String isDisplay;
    // 是否删除，Y：是，N：否
    private String isDelete;
    // 创建时间
    private Date createTime;
    // 删除时间
    private Date deleteTime;
    // 描述
    private String descrition;
    // 优惠信息
    private String discount;
    // 优惠价格
    private Double disPrice;
    // 花语
    private String language;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

	public String getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getDeleteTime() {
		return deleteTime;
	}

	public void setDeleteTime(Date deleteTime) {
		this.deleteTime = deleteTime;
	}

	public String getDescrition() {
		return descrition;
	}

	public void setDescrition(String descrition) {
		this.descrition = descrition;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public Double getDisPrice() {
		return disPrice;
	}

	public void setDisPrice(Double disPrice) {
		this.disPrice = disPrice;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
	
	
}