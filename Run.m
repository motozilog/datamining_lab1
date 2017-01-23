function Run()
tic;
RunPreProcessing();
RunFeature2Extraction();
RunSVM();
toc;
exit; %为命令行运行添加的
