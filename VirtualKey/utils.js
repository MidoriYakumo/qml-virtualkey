.pragma library

function isMobilePlatform() {
	return ["android", "blackberry", "ios", "winrt", "winphone"].indexOf(Qt.platform.os)>=0;
}

function mix(a, b, u) {
	return a*(1.-u)+b*u
}

String.prototype.setCharAt = function(index,chr) {
	if(index > this.length-1) return str;
	return this.substr(0,index) + chr + this.substr(index+1);
}
