<?php
date_default_timezone_set('Asia/Shanghai');

if ($_FILES["file"]["error"] > 0)
{
	echo "Error: " .  $_FILES["file"]["error"] . "<br />";
}
else
{
//	echo "Temp File:" . $_FILES["file"]["tmp_name"] . "<br />";
//	echo "FileName:" . $_FILES["file"]["name"] . "<br />";
	$FileName = explode(".",$_FILES["file"]["name"]);
	$FileExName = $FileName[count($FileName)-1];
//	echo $FileExName ."<br />";
//	echo date('Y-m-d_His') . "." . $FileExName;
	$FileDate = date('Y-m-d_His');
	copy($_FILES["file"]["tmp_name"] , "upload/" . $FileDate . "." .$FileExName);
	move_uploaded_file($_FILES["file"]["tmp_name"],"D:\SCUT\数据挖掘实验重做\部分程序\in.jpg");
	$command = "matlab -nojvm -nodesktop -nodisplay -nosplash -singleCompThread -wait -r Run -sd \"D:\SCUT\数据挖掘实验重做\部分程序\"";
	exec($command);
	
	$FileRunSVMOut = fopen("D:\SCUT\数据挖掘实验重做\部分程序\RunSVMOut.txt" , "r") or die ("Matlab输出文件有误");
	$Result = fread($FileRunSVMOut, filesize("D:\SCUT\数据挖掘实验重做\部分程序\RunSVMOut.txt"));
	fclose($FileRunSVMOut);
	
	echo "<img src = \"upload/" . $FileDate . "." .$FileExName . "\"><br />";
	echo "识别结果为: " . $Result;
	
	$FileSVMLog = fopen("SVMlog.txt", "a");
	fwrite($FileSVMLog, $FileDate . "." .$FileExName . "\t识别结果为: " . $Result . "\n");
	fclose($FileSVMLog);
}
?>