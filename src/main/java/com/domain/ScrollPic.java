package com.domain;

import java.util.Date;

/**
 * 滚动大图
 * @author zhenjunzhuo
 * 2016-11-02
 */
public class ScrollPic {
	private Long id;
    // 图片地址
    private String pic;
    // 排序号
    private Integer sortNum;
    // 信息
    private String info;
    // 是否删除，Y：是，N：否
    private String isDelete;
    // 创建时间
    private Date createTime;
    // 删除时间
    private Date deleteTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info == null ? null : info.trim();
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
    
    
}