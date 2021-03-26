
reduc1 = reduced_train_database(1:100,:)
labelred1 = train_label(1:100)


model = svmlearn(reduc1,labelred1,'-t 2 -g 0.1 -c 0.1');
[err , predictions ] = svmclassify(test_database_reduced, test_label, model);