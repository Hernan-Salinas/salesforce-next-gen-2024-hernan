trigger QuoteEmailTrigger on Quote (after update) {
    QuoteEmailHandler.sendQuoteEmail(Trigger.new, Trigger.oldMap);
}