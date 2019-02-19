create table sales_for_rfm (
   TimeId int not null, 
   CustomerID int not null,
   InvoiceNumber int not null,
   PreTaxTotalSale Numeric(9,2) not null,
   constraint sales_for_rfm_pk 
      Primary Key (TimeId, CustomerID, InvoiceNumber), 
   constraint srfm_timeline_fk foreign key(TimeId)
      references timeline(TimeId)
      on update no action
      on delete no action, 
   constraint srfm_customer_fk foreign key(CustomerID)
      references customer(CustomerID)
      on update no action
      on delete no action
   );
   
insert into sales_for_rfm 
(select t.timeid, inv.CustomerID, inv.InvoiceNumber, inv.SubTotal 
 from hsd.invoice as inv, hsddw.timeline as t
 where inv.invoicedate = t.date);
       