public class QuoteEmailHandler {
    public static void sendQuoteEmail(List<Quote> newQuotes, Map<Id, Quote> oldQuotes) {
        Id templateId = '00Xak000008qMnp';
        
        List<Quote> quotesWithRelations = [
            SELECT Id, Opportunity.Estudiante__c 
            FROM Quote 
            WHERE Id IN :newQuotes
        ];
        
        for(Quote q : quotesWithRelations) {
            Quote newQuote = (Quote)newQuotes.get(0);
            System.debug('EstadoCotizacion__c: ' + newQuote.EstadoCotizacion__c);
            
            if(oldQuotes == null || 
               (newQuote.EstadoCotizacion__c == 'Aprobada' && 
                oldQuotes.get(newQuote.Id).EstadoCotizacion__c != 'Aprobada')) {
                
                System.debug('Estudiante ID: ' + q.Opportunity.Estudiante__c);
                
                if(q.Opportunity.Estudiante__c != null) {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTargetObjectId(q.Opportunity.Estudiante__c);
                    mail.setTemplateId(templateId);
                    mail.setWhatId(q.Id);
                    mail.setSaveAsActivity(false);
                    
                    System.debug('Enviando email a: ' + q.Opportunity.Estudiante__c);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                }
            }
        }
    }
}