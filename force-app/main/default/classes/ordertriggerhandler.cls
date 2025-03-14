public with sharing class ordertriggerhandler {
   public static void publishevent(List<Order> ordedetails){
         //to get the order number - since we get the order id after saving  which will not be in trigger.new

         List<Order> orderwithorderid=[SELECT OrderNumber FROM Order WHERE Id IN:ordedetails];
         List<OrderStatus__e> Orderstatuspublish=new List<OrderStatus__e>();
         for(Order od:orderwithorderid){
            OrderStatus__e order1=new OrderStatus__e();
            order1.Ordernumber__c=Decimal.valueOf(od.OrderNumber);
            order1.Totalamount__c=0.0;
            Orderstatuspublish.add(order1);
         }
           //to publish the even we need to use event busapex class
           //we need to outside the forr loop dml statement , so add them in the list and publish all together
           EventBus.publish(Orderstatuspublish);

           //throw error when there is an erorr , and we selected the pubslish after commit - it wont publsh
           //since it has error
        //    Integer e=10/0;

   }
}