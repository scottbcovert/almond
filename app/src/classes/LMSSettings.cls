/*
Copyright (c) 2014, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
public with sharing class LMSSettings {

    public static String getCustomLogo(){
        return (String)getValue('Company_Logo__c',null);
    }

    public static String getHeaderBackgroundColor(){
        return (String)getValue('Header_Background_Color__c','#2A94D6');
    }

    public static String getHeaderTextColor(){
        return (String)getValue('Header_Text_Color__c','#DBE5F2');
    }

    public static String getHeaderTextHoverColor(){
        return (String)getValue('Header_Text_Hover_Color__c','#FFFFFF');
    }

    public static Boolean getDisableTrackAchievements(){
        return (Boolean)getValue('Disable_Track_Achievements__c',false);
    }

    public static Boolean getDisableFutureProgressCalculation(){
        return (Boolean)getValue('Disable_Future_Progress_Calculation__c',false);
    }

    public static Boolean getEnableIOSTapFix(){
        return (Boolean)getValue('Enable_iOS_Tap_Fix__c',false);
    }

    public static Boolean getShowSalesforceHeader(){
        return (Boolean)getValue('Show_Salesforce_Header__c',false);
    }

    public static String getBacktoSFUrl(){
        return (String)getValue('Back_to_SF_URL__c','/home/home.jsp');
    }

    public static Boolean getDisableCorrectResponseCheckbox(){
        return (Boolean)getValue('Disable_Correct_Response_Checkbox__c',false);
    }

    public static Boolean getDisableFeedItemAuditFields(){
        return (Boolean)getValue('Disable_Feed_Item_Audit_Fields__c',false);
    }

    private static Object getValue(String key, Object defaultValue){
        Almond_Settings__c cs = Almond_Settings__c.getInstance();
        if(cs != null && cs.get(key) != null){
            return cs.get(key);
        }else{
            return defaultValue;
        }
    }

}
