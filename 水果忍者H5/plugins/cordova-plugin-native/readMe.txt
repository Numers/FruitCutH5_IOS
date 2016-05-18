1.使用命令cordova plugin add 插件路径 导入插件
2.在js文件中使用
Native.play(function(value){
                  alert(value);
                  },function(value){
                  alert(value);
                  },’{\”file\”:\”menu\”}');

Native.stop(function(value){
                  alert(value);
                  },function(value){
                  alert(value);
                  });

Native.splitFruit(function(value){
                  alert(value);
                  },function(value){
                  alert(value);
                  },’{\”file\”:\”menu\”,\”type\”:\”0\”}’);
