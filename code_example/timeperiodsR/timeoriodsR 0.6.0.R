library(timeperiodsR)

# ���������������� �������� ���
options("timeperiodsR.custom_day_offs" = c("2020-01-14",
                                           "2020-01-15",
                                           "2020-01-16",
                                           "2020-01-17",
                                           "2020-02-05"))

Sys.Date()

# ��������� ������ tpr �� ������� �����
tm <- this_month()

# �������� ���������������� ��������
tm$dayoffs_marks

# ������ �� ���������������� ��������
tm$custom_day_offs

# ������ ����������� �������� ����������� ����������������� ���������
tm$official_day_offs

# #############################################
# ���� ��� ���� ������ ������� ���������� ���������������� ��������
cp <- custom_period("2020-01-14", "2020-01-30", "workdays")
options("timeperiodsR.custom_day_offs" = cp)

# ��������� ������ tpr �� ������� �����
tm <- this_month()

# �������� ���������������� ��������
tm$dayoffs_marks

# ������ �� ���������������� ��������
tm$custom_day_offs

# ������ ����������� �������� ����������� ����������������� ���������
tm$official_day_offs
