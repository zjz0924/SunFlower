/**
 *  工具类
 */


/**
 *  判断是否为空
 */
function isNull(data){
	if(data == null || data == "" || data == "undefined"){
		return true;
	}else{
		return false;
	}
}


/**
 * 判断是否为正整数
 */ 
function isPositiveNum(num){
	if(num == 0){
		return true;
	}
	
	var re = /^[0-9]*[1-9][0-9]*$/; 
	return re.test(num) 
}


/**
 * 判断是否为正整数, 则提示
 * @param field  字段ID
 * @param type   提示的字段名称
 * @returns {Boolean}
 */
function isPositive(field, type){
	if (!isPositiveNum($("#"+field).val())) {
		parent.errorTip("系统提示：提交失败，" + type + "为正整数");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 判断字段是否必填
 * @param field  字段ID
 * @param type   提示的字段名称
 * @returns {Boolean}
 */
function isRequired(field, type) {
	var data = $("#" + field).val();

	if (data == null || data == "" || data == "undefined") {
		parent.errorTip("系统提示：提交失败，" + type + "为必填");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 是否为数字
 * @param field
 * @param type
 * @returns {Boolean}
 */
function isDouble(field, type) {
	var data = $("#" + field).val();

	if (isNaN($("#"+ field).val())) {
		parent.errorTip("系统提示：提交失败，" + type + "为数字");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 判断两个密码是否相等
 * @param val1
 * @param val2
 * @returns {Boolean}
 */
function isEqual(val1, val2) {
	var data1 = $("#" + val1).val();
	var data2 = $("#" + val2).val();

	if (data1 != data2) {
		parent.errorTip("系统提示：提交失败，两次输入密码不一致");
		$("#" + val1).focus();
		$("#" + val1).val("");
		$("#" + val2).val("");
		return false;
	}
	return true;
}


//检查金额输入
function checkMoney(id){
	var money = $("#"+ id).val();
	if(isNull(money)){
		art.dialog.tips("请输入金额", 2, "error");
		$("#"+ id).focus();
		return false;
	}
	if(isNaN(money)){
		art.dialog.tips("请输入数字", 2, "error");
		$("#"+ id).focus();
		$("#"+ id).val('');
		return false;
	}
	return true;
}

/**
 * 检查手机号码 
 * @param mobile
 */
function checkMobile(mobile){
	if (!(/^1[3|4|5|7|8]\d{9}$/.test(mobile))) {
		return false;
	}
	return true;
}


// 格式化数字
function formatNum(val){
	if(parseInt(val) < 10){
		val = "0" + val;
    }
	return val;
}

/**
 * 格式化日期
 * @param date  整型 
 */
function formatDate(time){
	if(isNull(time)){
		return "";
	}else{
		var date = new Date(time * 1000);
		var str = date.getFullYear() + "-" + formatNum(date.getMonth()+1) + "-" + formatNum(date.getDate()) + " " + formatNum((date.getHours())) + ":" + formatNum(date.getMinutes()) + ":" + formatNum(date.getSeconds());
		return str; 
	}
}
