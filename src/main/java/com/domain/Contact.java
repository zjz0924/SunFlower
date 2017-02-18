package com.domain;

/**
 * 联系方式
 * @author zhenjunzhuo
 * 2016-11-02
 */
public class Contact {
	
    private Long id;
    // qq
    private String qq;
    // 手机号码
    private String phone;
    // 微信号
    private String wechat;
    // 二维码
    private String qr;
    // 地址
    private String address;
    // 联系人
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat == null ? null : wechat.trim();
    }

    public String getQr() {
        return qr;
    }

    public void setQr(String qr) {
        this.qr = qr == null ? null : qr.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}