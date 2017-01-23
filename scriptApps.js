    function saveDataApps() {
    	var _text = new Array();
    	var _idApps = $('#idApps').val();
    	var _tpl = $("#tplId").val();
    	var _token = $('input[name=_token]').val();    	
    	$('textarea[id^="text_statFirsNiv_"]').each(function(){
    		
    		var el = $(this).attr('id');
    		var id = el.split('_');
    		var obj = tinyMCE.get(el).getContent();
    		_text.push(obj+'|***|'+id[2]+'|***|'+id[3]);
    	});
        $('#modalAdd').modal().hide();
        var formData = {id_template:_tpl, id_app:_idApps, text:_text, _token: _token};
        var url = 'createParagrapApp';
        //if(_text_stat) {
            $("#loaderGlog").html('<img src="../../../../images/ajax-loader.gif"> Traitement...');
            $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {
            	var modified = 
            	'<i class="btn btn-success btn-xs fa fa-check" data-toggle="tooltip" data-placement="top" data-original-title="Cette partie a été modifié"></i>';
            	//$('span#nocheck_'+id).html(modified);
            var idApps = $('#idApps').val();
            $("#loaderGlog").html('');
            /*if (result == 'noModif') {
                return false;
            }
            if (result == 'ajoutApp') {            	
                var txt = 'La nouvelle partie '+ _text +' a bien été ajouté';
                var title = 'Ajout';                
            } else {
                var txt = 'La partie '+ _text +' a bien été modifié';
                var title = 'Modification';
                $('#vers').html(result);
            }*/            
                $.ajax({
                type: 'get',
                url: idApps+'/apps',
                success: function(result) {                    
                    swal({
                        title: title,
                        text: txt,
                        type: "success",
                        confirmButtonText: "Fermer"
                    });
                }
            });
            }
        });
        //}        
	}  

    function savetpl(id, obj) {
        var formData = '';
        var url = '';
        var _token = $('input[name=_token]').val();
        $("#modal_"+id).modal('hide');

        if (obj == 'title') {
            var text = $('#text_parent_'+id).val();
            var text_stat = tinyMCE.get('text_statFirsNiv_'+id).getContent();
            var formData = {id:id, text_stat:text_stat, text:text, _token: _token};
            url = "update";
            $("#title_"+id).html('<img src="../../../images/ajax-loader.gif">');
        } else {
            var title = $('#text_parent_'+id).val();
            var text = tinyMCE.get('text_statFirsNiv_'+id).getContent();
            var formData = {id:id, text_stat:text,text:title, _token: _token};
            url = "update";
            $("#loader_"+id).html('<img src="../../../images/ajax-loader.gif"> Modifier...');
        }                
        $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {
                if (obj == 'title') {
                    $("#title_"+id).html(text);
                } else {
                    $("#loader_"+id).html('');
                }
            }
        });
    }

    function addNewParagraph(id) {
        var _text = $("#text_new").val();
        var _text_stat = tinyMCE.get('prgN').getContent();
        var _token = $('input[name=_token]').val();
        var formData = {
            id:id, text:_text, text_stat:_text_stat, _token: _token
        };
        var url = 'createNewParagraph';
        if(_text) {
            $("#modal_add_cmp").modal('hide');
            $("#loaders").css('display', '');
            //$("#tpl").hide().fadeIn('slow');
            $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {                
                $.ajax({
                type: 'get',
                url: 'tpls',
                success: function(result) {
                    $("#loaders").css('display', 'none');
                    $("#tpl").hide().html(result).fadeIn('slow');
                    $(function () {
                       $.loadScript('../../../laralum_public/js/tinymce/tinymce.min.js', {'charset': 'UTF-8'}, function () {
                           $('span[id^="title_"]').on('click', function(){
                             var el = (this.id).split('_');
                             wiziAddTpl("mceEditor_"+el[1], 0);                             
                           });
                           wiziAddTpl("mceEditorAdd", 0);
                       });
                     });    
                    swal({
                        title: "Ajout",
                        text: "La nouvelle partie "+ _text +" a bien été ajoutée",
                        type: "success",
                        confirmButtonText: "Fermer"
                    }); 
                }
            });
            }
        });
        }
    }

    function addParagraph(id, parag, niv, id_template) {
        var _text = $("#text_parent_add_"+id).val();
        var _text_stat = tinyMCE.get('text_stat_parent_add_'+id).getContent();
        var _numPrg = parag;
        var id_template = id_template;
        var _token = $('input[name=_token]').val();
        var formData = {
            id:id, text:_text, text_stat:_text_stat, niv:niv, numPrg:parag, _token: _token, id_template:id_template
        };
        var url = 'createParagraph';
        if(_text) {
            $("#modal_add_"+id).modal('hide');
            $("#loaders").css('display', '');
            $(".row").hide();
            $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {                
                $.ajax({
                type: 'get',
                url: 'tpls',
                success: function(result) {
                    $("#loaders").css('display', 'none');
                    $("#tpl").hide().html(result).fadeIn('slow');
                    $(function () {
                        $.loadScript('../../../laralum_public/js/tinymce/tinymce.min.js', {'charset': 'UTF-8'}, function () {
                            $('span[id^="title_"]').on('click', function(){
                                var el = (this.id).split('_');
                                wiziAddTpl("mceEditor_"+el[1], 0);                                
                            });
                            wiziAddTpl("mceEditorAdd", 0);
                       });
                    });    
                    swal({
                        title: "Ajout",
                        text: "La nouvelle partie "+ _text +" a bien été ajoutée",
                        type: "success",
                        confirmButtonText: "Fermer"
                    });
                }
            });
            }
        });
        }
        /**/
    }
    // Alert delete    
     function deletPrg(id, niv, numPrg, parentId)
     {
         swal({
          title: "Suppression",
          text: "Etes-vous sur de vouloir supprimer le paragraphe "+numPrg,
          type: "warning",
          showCancelButton: true,
          confirmButtonClass: "btn-danger",
          confirmButtonText: "Supprimer",
          closeOnConfirm: true
        },
        function(){
            var _token = $('input[name=_token]').val();
            var formData = {
                id:id, niv:niv, numPrg:numPrg, parentId:parentId, _token: _token
            };
            var url = 'deleteParagraph';
            $.ajax({
                type: 'post',
                data : formData,
                url: url,
                success: function(result) {
                    $.ajax({
                        type: 'get',
                        url: 'tpls',
                        success: function(result) {
                            $("#loaders").css('display', 'none');
                            $("#tpl").hide().html(result).fadeIn('slow');
                            $(function () {
                                $.loadScript('../../../laralum_public/js/tinymce/tinymce.min.js', {'charset': 'UTF-8'}, function () {
                                    $('span[id^="title_"]').on('click', function(){  
                                        var el = (this.id).split('_');
                                        wiziAddTpl("mceEditor_"+el[1], 0);
                                    });
                                    wiziAddTpl("mceEditorAdd", 0);
                                });
                            });                    
                        }
                    });
                    swal("", "Le patragraphe a bien été supprimer.", "success");
                }
            });
        });
     }
     // Ajouter nouvelle application
     function addParagraphApp(id) {
        var _text = $("#text_"+id).val();
        var _text_stat = tinyMCE.get('text_statFirsNiv_'+id).getContent();
        var _niv = $("#niv_"+id).val();
        var _parent = $("#parent_"+id).val();
        var _ordre = $("#ordre_"+id).val();
        var _tpl = $("#tpl_"+id).val();
        var _idApps = $('#idApps').val();
        var _numPrg = $("#num_parag_"+id).val();
        var _id_parent_tpl = $("#id_parent_tpl_"+id).val();
        var _token = $('input[name=_token]').val();
        var formData = {
            ordre:_ordre, text:_text, text_stat:_text_stat, niv:_niv, numPrg:_numPrg, _token: _token, id_template:_tpl,
            parent:_parent, id_app:_idApps, id_parent_tpl:_id_parent_tpl
        };
        var url = 'createParagrapApp';
        if(_text_stat) {
            $("#loader_"+id).html('<img src="../../../../images/ajax-loader.gif"> Traitement...');
            $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {
            	var modified = 
            	'<i class="btn btn-success btn-xs fa fa-check" data-toggle="tooltip" data-placement="top" data-original-title="Cette partie a été modifié"></i>';
            	$('span#nocheck_'+id).html(modified);
            var idApps = $('#idApps').val();
            $("#loader_"+id).html('');
            if (result == 'noModif') {
                return false;
            }
            if (result == 'ajoutApp') {            	
                var txt = 'La nouvelle partie '+ _text +' a bien été ajouté';
                var title = 'Ajout';                
            } else {
                var txt = 'La partie '+ _text +' a bien été modifié';
                var title = 'Modification';
                $('#vers').html(result);
            }            
                $.ajax({
                type: 'get',
                url: idApps+'/apps',
                success: function(result) {                    
                    swal({
                        title: title,
                        text: txt,
                        type: "success",
                        confirmButtonText: "Fermer"
                    });
                }
            });
            }
        });
        }        
    }

    // Ajouter Aide
     function addHelp(id) {
     	$('#modal_add_'+id).modal('hide');
        var _help = tinyMCE.get('aidedit_'+id).getContent();
        var _token = $('input[name=_token]').val();
        var formData = {  _token: _token, help:_help, id:id };
        var url = 'modifHelp';
        if(_help) {
            $("#loader_"+id).html('<img src="../../../../images/ajax-loader.gif"> Traitement...');
            $.ajax({
            type: 'post',
            data : formData,
            url: url,
            success: function(result) {
            $("#loader_"+id).html('');
            }
        });
        }        
    }
    // Monter en version
    function versionUp() {
        var app = $("#appname").val();   
        var _token = $('input[name=_token]').val();
        var formData = { app:app, _token: _token};
        swal({
           title: "Version Majeure",
           text: "Voulez-vous monter à une version majeure ?",
           type: "info",
           showCancelButton: true,
           closeOnConfirm: false,
           showLoaderOnConfirm: true
        }, function () {
            $('#vers').html('<img src="../../../../images/ajax-loader.gif"> Traitement...');
            $.ajax({
                type: 'post',
                url: 'versionup',
                data: formData,
                success: function(result) {
                    $('#vers').html(result);
                    setTimeout(function () {
                        swal("Nouvelle version "+result+"!");
                    });
                }
            });
        });
    }

    function modifComment(id) {
    	
        $('#ftr_'+id).show().fadeIn('slow');
        $('#mdf_'+id).hide().fadeOut('slow');
        /*$('textarea#aideInput_'+id).replaceWith(function() {
            return "<textarea id='aidedit_"+id+"' class='aidedit_"+id+"'>" + this.innerHTML + "</textarea>";
		});*/
		wiziAddTpl("aidedit_"+id, 0);
	}

	function wizyAffiche(id, access) {
		wiziAddTpl("aidedit_"+id, access);
	}

    //Wizywig generique
     function wiziAddTpl(_id, readO) {
         var wizy = tinyMCE.init({
             mode : "specific_textareas",
             editor_selector : _id,
             readonly : readO,
             autoresize_overflow_padding: 10,
             theme: 'modern',
             plugins: [
               'autoresize lists image preview',
               'fullscreen',
               'save table contextmenu directionality',
               'textcolor colorpicker textpattern'
             ],
             toolbar1: 'undo redo | styleselect | bold italic underline forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | preview media | responsivefilemanager ',
             image_advtab: true,
             relative_urls: false,
 
             filemanager_title:"Responsive Filemanager",
             filemanager_crossdomain: false,
             /*external_filemanager_path:"{!! str_finish(asset('/templates'),'/') !!}",
            external_plugins: { "filemanager" : "{!! str_finish(asset('/templates'),'/') !!}/plugin.min.js"},*/
            external_filemanager_path:"/refarc/public/applications/",
			external_plugins: { "filemanager" : "http://localhost/refarc/public/templates/plugin.min.js"},          
                     content_css: [
                       '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
                       '//www.tinymce.com/css/codepen.min.css'
                     ]
         });
         return wizy;
     }
