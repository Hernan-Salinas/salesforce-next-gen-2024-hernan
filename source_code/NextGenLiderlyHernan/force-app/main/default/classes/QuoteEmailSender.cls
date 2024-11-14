public class QuoteEmailSender {
    public static void sendSingleQuoteEmail(Id quoteId, Id contactId, String emailAddress) {
        Id templateId = '00Xak000008qMnp';
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(templateId);
        mail.setTargetObjectId(contactId);
        mail.setWhatId(quoteId);
        mail.setSaveAsActivity(false);
        mail.setToAddresses(new String[] { emailAddress });  // Email específico
        
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            System.debug('Email enviado exitosamente');
        } catch(Exception e) {
            System.debug('Error al enviar email: ' + e.getMessage());
        }
    }
}