M1 = csvread('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_iters\1\results.csv',1,1)
M2 = csvread('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_iters\2\results.csv',1,1)
M3 = csvread('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_iters\3\results.csv',1,1)
M4 = csvread('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_iters\4\results.csv',1,1)
M5 = csvread('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_iters\5\results.csv',1,1)

total_M = M1 + M2 + M3 + M4 + M5;
avg_M = total_M/5;

figure(1)
clf;
plot(avg_M(:,1),'r-.','Linewidth',2)
hold on
plot(avg_M(:,2),'g--','Linewidth',2)
grid on