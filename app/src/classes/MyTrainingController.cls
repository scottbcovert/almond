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
public with sharing class MyTrainingController {

    private transient List<Training_Plan__c> trainingPlans{get;private set;}
    public transient List<TrainingPlanWithAchievement> tPlans{get;private set;}
    public String selectedType{get;set;}

    public MyTrainingController(){
        init();
    }

    private void init(){
        tPlans = new List<TrainingPlanWithAchievement>();
        selectedType = LMSConstants.TPLAN_STATUS_NOT_STARTED;

        String urlStatus = Apexpages.currentPage().getParameters().get('status');
        if(!String.isBlank(urlStatus)){
            selectedType = urlStatus;
        }

        loadTrainingPlans();
    }

    public void loadTrainingPlans(){

        if(selectedType == LMSConstants.TPLAN_STATUS_COMPLETED){
            trainingPlans = LMSService.getCompletedTrainingPlans(UserInfo.getUserId());
        }else if(selectedType == LMSConstants.TPLAN_STATUS_IN_PROGRESS){
            trainingPlans = LMSService.getInProgressTrainingPlans(UserInfo.getUserId());
        }else if(selectedType == LMSConstants.TPLAN_STATUS_NOT_STARTED){
            trainingPlans = LMSService.getNewTrainingPlans(UserInfo.getUserId());
        }else{
            trainingPlans = new List<Training_Plan__c>();
        }

        createWrapperObjects(trainingPlans);

    }

    private void createWrapperObjects(List<Training_Plan__c> trainingPlans){

        tPlans = new List<TrainingPlanWithAchievement>();
        //Create wrapper objects that include main reward information
        if(trainingPlans.size()>0){

            PageReference tempRef = Page.TrainingPlanDetail;

            Map<Id,Achievement__c> tmp = LMSService.getTrainingMainAchievements(LMSUtils.objectListToIdSet(trainingPlans));

            for(Training_Plan__c tp : trainingPlans){
                if(tp.Status__c == LMSConstants.TPLAN_STATUS_ACTIVE || LMSUtils.isAdminUser()){
                    tPlans.add(new TrainingPlanWithAchievement(tp, tmp.get(tp.Id),tempRef.getUrl(), true));
                }
            }
        }
    }


}
