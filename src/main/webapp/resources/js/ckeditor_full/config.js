/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	//测试环境
	config.filebrowserBrowseUrl='/flowerController/uploadEditorFile';
	config.filebrowserUploadUrl='/flowerController/uploadEditorFile';
	
	//生产环境
	//config.filebrowserBrowseUrl='/ticket-support/showGroup/uploadEditorFile.do';
	//config.filebrowserUploadUrl='/ticket-support/showGroup/uploadEditorFile.do';
	
};
