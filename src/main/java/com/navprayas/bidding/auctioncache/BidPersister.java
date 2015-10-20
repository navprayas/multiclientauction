package com.navprayas.bidding.auctioncache;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.engine.orm.Bid;

/**
 * This Class Is for persist the bid object to
 * 
 * @author cfeindia
 * 
 */
@Component
public class BidPersister {
	private static final Logger logger = LoggerFactory
			.getLogger(BidPersister.class);

	@Autowired
	private SessionFactory sessionFactory;

	/**
	 * This Method is using for persisting the database using hibernate session
	 * factory
	 * 
	 * @param itemsList
	 */
	public void persist(final List<Bid> itemsList) {
		logger.debug("Persist" + itemsList);
		convertAndSaveBidobjectToBidsEntity(itemsList);
	}

	/**
	 * This method convert to bid entity object and save to database using
	 * hibernate session object in batch form
	 * 
	 * @param itemsList
	 */
	private void convertAndSaveBidobjectToBidsEntity(List<Bid> itemsList) {
		logger.debug("saving the entity to database");
		Bids bids = null;
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		for (Bid bid : itemsList) {
			bids = new Bids();
			BidItem bidItem=new BidItem();
			bidItem.setBidItemId(bid.getBidItemId());
			bids.setBidItem(bidItem);
			bids.setAuctionId(bid.getAuctionId());
			bids.setBidId(bid.getBidItemId());
			bids.setBidAmount(bid.getBidAmount());
			bids.setCurrency(bid.getCurrency());
			bids.setComments(bid.getComments());
			bids.setBidStatus(bid.getStatus());
			bids.setBidType(bid.getBidType() == 1 ? '1' : '2');
			bids.setBidderName(bid.getBidderName());
			bids.setBidTime(bid.getBidTime());
			session.save(bids);
		}
		session.flush();
		tx.commit();
		logger.debug("Transaction commited to ");
	}

}