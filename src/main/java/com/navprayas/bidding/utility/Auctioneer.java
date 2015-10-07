package com.navprayas.bidding.utility;

import kilim.Mailbox;

import org.hibernate.SessionFactory;

import com.navprayas.bidding.engine.orm.Bid;

public abstract interface Auctioneer
{
  public abstract Mailbox<Bid> getMailBox();
  
  public abstract void stopAuction();
  
  public abstract boolean startAuction()
    throws Exception;
  
  public abstract void registerSessionFactory(SessionFactory paramSessionFactory);
  
  public abstract void restart();
}

