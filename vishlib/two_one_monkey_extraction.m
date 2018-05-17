load('forVish.mat')
load('input_matrix.mat')
monkey_1_indices = find(strcmp(monkey_name, 'NHP'));
monkey_2_indices = find(strcmp(monkey_name, 'diesel'));
monkey_3_indices = find(strcmp(monkey_name, 'ross'));
cp_input = input_matrix;
cp_input(:,181) = zeros(57267,1);
cp_input(monkey_1_indices,181) = 1;
cp_input(monkey_2_indices,181) = 2;
cp_input(monkey_3_indices,181) = 3;
outlier_groups = [5455 27271 28180 30907 31816 36361];
output_indices = [];

for i = 1:length(outlier_groups)
    temp = outlier_groups(i):(outlier_groups(i)+908);
    output_indices = [output_indices,temp];
end

cp_input_v2 = cp_input;
cp_input_v2(output_indices,:) = [];

load('out_matrix.mat')
out_matrix(output_indices,:) = [];

train_two_monkey_input = [];
train_two_monkey_output = [];
test_one_monkey_input = [];
test_one_monkey_output = [];

for i = 1:length(cp_input_v2)
    
    if (cp_input_v2(i,181) == 1)
        train_two_monkey_input = [train_two_monkey_input;cp_input_v2(i,:)];
        train_two_monkey_output = [train_two_monkey_output;out_matrix(i,:)];
    end
    
    if (cp_input_v2(i,181) == 3)
        train_two_monkey_input = [train_two_monkey_input;cp_input_v2(i,:)];
        train_two_monkey_output = [train_two_monkey_output;out_matrix(i,:)];
    end
    
    if (cp_input_v2(i,181) == 2)
        test_one_monkey_input = [test_one_monkey_input;cp_input_v2(i,:)];
        test_one_monkey_output = [test_one_monkey_output;out_matrix(i,:)];
    end
    
end