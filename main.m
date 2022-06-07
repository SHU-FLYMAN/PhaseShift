% 论文：基于数字光栅投影的结构光三维测量技术与系统研究 [博] 
% 作者: 李中伟 华中科技大学 2007
% 功能：相移法：多频外差（三频四相）
% 复现：天涯居士
% 邮箱：fly_cjb@163.com
% 时间：2022.06.01
clear; clc;
close all;

%% 超参数
width  = 1280;        % 投影仪分辨率：高
heigth = 720;         % 投影仪分辨率：宽
Ts     = [70 64 59];  % freq = 1 / T,
A      = 128;         % 调制强度
B      = 127;         % 调制幅值
N      = 12;          % 相移步数 
save_dir = "output/";


%% step1. 条纹生成
Is = cell(3, N);  
for i = 1: 3
    for k = 1: N
        Is{i, k} = zeros(heigth, width);
    end
end

for i = 1: 3     % 对应三种不同的频率
    for k = 1: N % 对应N步相位
        for x = 1: width 
            %Is{i, k}(:, x) = (A + B * cos(2 * pi  *  x / Ts(i) + (k - 1) * (2 * pi / N))) / 255.;
            Is{i, k}(:, x) = (A + B * cos(2 * pi * Ts(i) *  x /  width + (k - 1) * (2 * pi / N))) / 255.;
        end
        m_save_phase_map(Is{i, k}, save_dir + "img" + int2str(k) + ".bmp");
    end
end
 


%% step2. 包裹相位
pha = cell(3, 1);

for i = 1: 3
    pha{i, 1} = m_calc_wrapped_phase(Is, N, i);
end

%% step3. 相位展开
pha1 = pha{1, 1};
pha2 = pha{2, 1};
pha3 = pha{3, 1};
pha12 = m_calc_absolute_phase(pha1, pha2);
pha23 = m_calc_absolute_phase(pha2, pha3);
pha123 = m_calc_absolute_phase(pha12, pha23);


%% step4. 查看结果
m_save_phase_map(pha1, save_dir + '1相位主值.bmp');
m_save_phase_map(pha2, save_dir + '2相位主值.bmp');
m_save_phase_map(pha3, save_dir + '3相位主值.bmp');
m_save_phase_map(pha12, save_dir + '1,2外差.bmp');
m_save_phase_map(pha23, save_dir + '2,3外差.bmp');
m_save_phase_map(pha123, save_dir + '1,2,3外差.bmp');

figure; plot(pha123(1, :)); title("某行相位.bmp");
