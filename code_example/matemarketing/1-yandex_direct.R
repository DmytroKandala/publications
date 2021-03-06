# ��������� �������
install.packages("devtools")
devtools::install_github("selesnow/ryandexdirect")

# ����������� ������
library(ryandexdirect)

# ��������� � ������� ����������
getwd()                   # ������� ����������
setwd("C:/matemarketing") # ������������� ����� ������� ����������
getwd()                   # ������� ����������

# ����������� 
invisible(
    # ===============================================
    yadirAuth(Login     = "netpeak.vyacheslav", 
              TokenPath = "C:/matemarketing/tokens")
    # ===============================================
)

# �������� ������ ���������� ������� �� ������������ ������
browseURL("https://passport.yandex.ru/profile/access")

# ###################################################
# �������� ��������� �������� �� ���������� ��������
# ###################################################

# ������ ��������� ��������
camp <- yadirGetCampaignList(Logins = "netpeak.vyacheslav",
                             TokenPath = "C:/matemarketing/tokens",
                             States = "ON",
                             Types  = "TEXT_CAMPAIGN")

# ������ �������� ����
kw <- yadirGetKeyWords(Login       = "netpeak.vyacheslav",
                       TokenPath   = "C:/matemarketing/tokens",
                       CampaignIds = camp$Id[c(1,2)],
                       States      = "ON")

# ������ ����� ����������
adgroups <- yadirGetAdGroups(Login       = "netpeak.vyacheslav",
                             TokenPath   = "C:/matemarketing/tokens",
                             CampaignIds = camp$Id[c(1,2)],
                             Types       = "TEXT_AD_GROUP",
                             Statuses    = c("ACCEPTED", "MODERATION"))

# ������ ����������
ads <- yadirGetAds(Login       = "netpeak.vyacheslav",
                   TokenPath   = "C:/matemarketing/tokens",
                   CampaignIds = camp$Id[c(1,2)])

# ������ ������� ������ 
links <- yadirGetSiteLinks(Login       = "netpeak.vyacheslav",
                           TokenPath   = "C:/matemarketing/tokens")

# ###################################################
# �������� ���������� ����������
# ###################################################

# ����� �����
currency <- yadirGetDictionary(DictionaryName = "Currencies",
                               Language       = "en",
                               Login          = "netpeak.vyacheslav",
                               TokenPath      = "C:/matemarketing/tokens")

# �������������� ����������
regions <- yadirGetDictionary(DictionaryName = "GeoRegions",
                              Language       = "ru",
                              Login          = "netpeak.vyacheslav",
                              TokenPath      = "C:/matemarketing/tokens")

# ###################################################
# �������� ����������
# ###################################################

# ���������� ����� �� ������� �����
simple_report <- yadirGetReport(DateRangeType = "LAST_MONTH",
                                FieldNames    = c("Date", "Clicks", "Impressions"),
                                Login         = "netpeak.vyacheslav",
                                TokenPath     = "C:/matemarketing/tokens")

# ����� �� ���������� � ������� ���������� �� ��������� ������
attribution_report <- yadirGetReport(DateFrom          = "2018-10-15",
                                     DateTo            = "2018-10-20",
                                     FieldNames        = c("Date", 
                                                           "Conversions"),
                                     Goals             = c(182453, 182452, 23458860),
                                     AttributionModels = c("LC", "FC"),
                                     Login             = "netpeak.vyacheslav",
                                     TokenPath         = "C:/matemarketing/tokens")

# ����� � ����������� ����������
filtring_report <- yadirGetReport(DateRangeType = "LAST_30_DAYS",
                                  FieldNames    = c("Date", "Clicks", "Impressions"),
                                  FilterList    = c("Conversions LESS_THAN 300", 
                                                    "Impressions GREATER_THAN 15000"),
                                  Login         = "netpeak.vyacheslav",
                                  TokenPath     = "C:/matemarketing/tokens")

# ###################################################
# ���������� ��������
# ###################################################

on_ads <- ads[ads$State == "ON", ] # �������� ���������� ����������
ads_to_off <- on_ads[1:3, ]        # ��������� 3 ������� ���� ���������

# ��������� �������
yadirStopAds(Ids        = ads_to_off$Id,
             Login      = "netpeak.vyacheslav",
             TokenPath  = "C:/matemarketing/tokens")

# �������� ��� ���������� ���������
cheking_ads_1 <- yadirGetAds(Ids        = ads_to_off$Id,
                             Login      = "netpeak.vyacheslav",
                             TokenPath  = "C:/matemarketing/tokens")

# ������� ������� ������ ����������
message(unique(cheking_ads_1$State))

# ������ �������
yadirStartAds(Ids        = ads_to_off$Id,
              Login      = "netpeak.vyacheslav",
              TokenPath  = "C:/matemarketing/tokens")

# �������� ��� ���������� ����������
cheking_ads_2 <- yadirGetAds(Ids        = ads_to_off$Id,
                             Login      = "netpeak.vyacheslav",
                             TokenPath  = "C:/matemarketing/tokens")

# ������� ������� ������ ����������
message(unique(cheking_ads_2$State))
