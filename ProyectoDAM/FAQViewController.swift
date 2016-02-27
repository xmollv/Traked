//
//  FAQViewController.swift
//  
//
//  Created by Tania Fontcuberta Mercadal on 27/2/16.
//
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var faq : [AnswerQuestion] = [
        AnswerQuestion(
            question: "¿How do I watch a TV show or movie??",
            answer:  "We don’t actually stream any TV shows or movies to watch on Trakt.tv. We help you track what you're watching and discover new TV shows and movies."
        ),
        AnswerQuestion(
            question: "How do I add a missing TV show?",
            answer:  "We use a combination of TMDB and TVDB for TV show information. TMDB is used for the top level show info like title, year, genres, and country. It is also used for high quality posters, fanart, and episode screenshots. TVDB is used for all season and episode info and as a fall back for info missing on TMDB."
        ),
        AnswerQuestion(
            question: "¿How do I add a missing movie?",
            answer:  "This is actually by design. The watchlist is a specific list for you to remember to watch something. Once you watch it, it automatically gets removed. In the case of shows, once you watch 1 episode, the site knows about it and the show will continue showing up on your personal calendar and progress views. So, there is no need to keep it on the watchlist. If you need to keep something around, you can always make a custom list."
        ),
        AnswerQuestion(
            question: "¿Why does a show's progress say 0 out of 0 episodes??",
            answer:  "In order to correctly determine your watched or collected progress, all episodes need air dates. We use this date to know if the episode has actually aired or not. For currently airing shows, this ensures future episodes aren't counted. For shows that have ended, this helps so that unaired (for cancelled shows) or DVD only episodes aren't counted. You can add air dates on TVDB and Trakt.tv will automatically sync up that night. Your progress will start calculating correctly after Trakt.tv has the air dates."
        )
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if there are seasons. If there are, we shouldn't download again the same seasons. This should be checked
        
        
        // let hudView = HudView.hudInView(view,animated: true)
        
        title = "FAQ"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return faq.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewFAQ", forIndexPath: indexPath) as! TableViewFAQ
        if faq.count != 0 {
            
            cell.label.text = faq[indexPath.section].answer
            
        } else {
            cell.label.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return faq[section].question
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
}
