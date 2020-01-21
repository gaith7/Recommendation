clm_3={[1 2 5 6] [1 3 4], [1 6 7], [2 3 6 7], [2 4 7], [2 5 7], [4 5 6 7], [1 2 3 4 5 6 7]};
vlm_3=[10 5 4 12 4 6 15 25];
tic;[v_3 sS_3]=vclToMatlab(clm_3,vlm_3);toc
disp('numel(clm_3)');
disp(numel(clm_3));
disp('v_3');
disp(v_3);
disp('sS_3');
disp(sS_3);
dec2bin(sS_3,7);
tic;sS_3a=clToMatlab(clm_3);toc
disp('sS_3a');
disp(sS_3a);
[e,A,smat]=p_BestCoalitions(v_3,sS_3,0);
[crq x]=p_coreQ(v_3);
disp('crq');
disp(crq);
disp('x');
disp(x);
