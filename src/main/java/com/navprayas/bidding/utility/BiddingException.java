/*    */ package com.navprayas.bidding.utility;
/*    */ 
/*    */ 
/*    */ 
/*    */ public class BiddingException
/*    */   extends Exception
/*    */ {
/*    */   public static final long serialVersionUID = 653235685664321L;
/*    */   
/*    */   private int code;
/*    */   
/*    */ 
/*    */   public BiddingException(String message)
/*    */   {
/* 15 */     super(message);
/*    */   }
/*    */   
/*    */ 
/*    */   public BiddingException(String message, int code)
/*    */   {
/* 21 */     super(message);
/* 22 */     this.code = code;
/*    */   }
/*    */ }

