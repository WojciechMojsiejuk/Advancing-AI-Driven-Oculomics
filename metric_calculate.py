import pandas as pd
import numpy as np
from scipy import stats

def calculate_mean_and_ci(file_path, output_file_path):
    # 读取CSV文件
    data = pd.read_csv(file_path)
    
    # 计算每个指标的平均值、标准差和标准误差
    mean_values = data.mean(axis=0)
    std_dev = data.std(axis=0)
    std_error = std_dev / np.sqrt(data.shape[0])
    
    # 计算95%置信区间
    confidence_interval = 1.96 * std_error
    
    # 创建结果DataFrame
    results = pd.DataFrame({
        'Mean': mean_values,
        'Standard Error': std_error,
        '95% CI Lower Bound': mean_values - confidence_interval,
        '95% CI Upper Bound': mean_values + confidence_interval
    })
    
    # 将结果写入新的CSV文件
    results.to_csv(output_file_path,mode='a',index_label='Retina')
    return results


# 示例用法
file_path = '/projappl/project_2009557/Foundation_model_retinal_disease/RETFound_MAE_直接调用/script/finetune_Retina/_metrics_test.csv'
output_file='result.csv'
results = calculate_mean_and_ci(file_path,output_file)

