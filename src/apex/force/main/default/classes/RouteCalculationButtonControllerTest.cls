/**
 * Copyright (c) 2017, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors
 *      may be used to endorse or promote products derived from this software without
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

@isTest(SeeAllData=false)
private class RouteCalculationButtonControllerTest
{
	@IsTest
	private static void calculateRoute_ShouldCallTheHerokuConnectorForSampleAppCalculateRouteMethod()
	{
		// given
		StubProvider mocks = new StubProvider();

		HerokuConnectorForSampleApp mockConnector = (HerokuConnectorForSampleApp)mocks.mock(HerokuConnectorForSampleApp.class);
		HerokuConnectorForSampleApp.instance = mockConnector;

		mocks.stub(mockConnector, 'calculateRoute', new Type[]{ String.class }, new Object[]{ 'Test' }, null);

		// when
		RouteCalculationButtonController.calculateRoute('Test');

		// then
		System.assertEquals(1, mocks.getCallCount(mockConnector, 'calculateRoute', new Type[]{ String.class }, new Object[]{ 'Test' }));
	}

	@IsTest
	private static void getPlanStatus_withId_shouldReturnPlanStatus()
	{
		// given
		String expectedResult = 'NOT STARTED';
		
		DeliveryPlan__c plan = new DeliveryPlan__c();
		insert plan;

		// when
		String result = RouteCalculationButtonController.getPlanStatus(plan.id);

		// then
		System.assertEquals(expectedResult, result);
	}

	@IsTest
	private static void sendInitialPlatformEvent_withId_shouldReturnSuccess()
	{
		// given
		DeliveryPlan__c plan = new DeliveryPlan__c();
		insert plan;

		// when
		Test.startTest();
		Boolean result = RouteCalculationButtonController.sendInitialPlatformEvent(plan.id);
		Test.stopTest();

		// then
		System.assertEquals(true, result);
	}
}
