// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
 import socket from "./socket"

 let channel=socket.channel("room:lobby",{})
 let chatInput=document.querySelector("#chat-input")
 let messagesContainer=document.querySelector("#messages")
 let user=document.querySelector("#usrnm")
 let follow_button=document.querySelector("#follower")
 let follower_name=document.querySelector("#follower_user")
 let tweetbtn=document.querySelector("#tweetbtn")
 let hashtag=document.querySelector("#hashtag_btn")
 let hashtag_content=document.querySelector("#hashtags")
 let temp="";
 let mention_username=document.querySelector("#mentions")
 let mention_btn=document.querySelector("#mention_btn")
 let temp2="";
 let delete_button=document.querySelector("#delete_button")
let mentionpane=document.querySelector("#mens")
 let hashtagpane=document.querySelector("#hashers")

 tweetbtn.addEventListener("click",event=>{
   let cur_mention=chatInput.value.split(' ').filter(v=>v.startsWith('@'));
   for(let i=0;i<cur_mention.length;i++){
     let curr=cur_mention[i];
     channel.push("addmentions",
      {username: user.innerText,mention_username: curr,tweet: chatInput.value})
    }

      let cur_tweet=chatInput.value.split(' ').filter(v=>v.startsWith('#'));
      for(let i=0;i<cur_tweet.length;i++){
        let curr=cur_tweet[i];
        channel.push("addhashtags",
         {hashtag: curr,tweet: chatInput.value,username: user.innerText})
      }

     channel.push("new_msg",
      {username: user.innerText,feed: chatInput.value})
   channel.push("addinfollowersfeed",{username: user.innerText, tweeter: user.innerText,tweet: chatInput.value})

   chatInput.value=""
});



 follow_button.addEventListener("click",event=>{
   //console.log(follower_name.value)
   // addfollowing();
   channel.push("follow",
   {username: follower_name.value,fan: user.innerText})
   alert("followed "+follower_name.value+" successfully!!")

   follower_name=""
 })
 // function addfollowing(){
 //   channel.push("following",
 //   {username: user.innerText,foll: follower_name.value})
 // }

channel.on("addinfollowersfeed",payload=>{
  let messageItem=document.createElement("h3")
  let tweetbox=document.createElement("div")
  let buts=document.createElement("button")
  buts.innerText="Retweet"

  buts.onclick=function(){
    retweet(buts)
  }
  //console.log("hurrayyyyyyyyyyyyyyyy")


  //console.log(user.innerText)
  if (payload.username==user.innerText ){
    messageItem.innerText=`${payload.tweeter}: ${payload.tweet}`
    tweetbox.appendChild(messageItem)

    tweetbox.appendChild(buts)
    messagesContainer.appendChild(tweetbox)
  }


});
delete_button.addEventListener("click",event=>{
  channel.push("deleteaccount",{name:"abc",username: user.innerText,password_hash: "123456" })
  alert(user.innerText+" deleted successfully!!")
  window.location.href="http://localhost:4000"
})


function retweet(buts){
  let children=buts.parentElement.childNodes
  let twts=children[0].innerText;
  let array=twts.split(":")
  let finaltweet="\nretweeted @"+array[0]+":"+array[1]
  alert(finaltweet)
  channel.push("new_msg",
   {username: user.innerText,feed: finaltweet})
channel.push("addinfollowersfeed",{username: user.innerText, tweeter: user.innerText,tweet: finaltweet})

 document.location.reload();

}

mention_btn.addEventListener("click",event=>{
  mentionpane="";
temp2=  mention_username.value
  channel.push("search_mention",
   {username: "xyz",mention_username: "@e",tweet: "asd"})


})

hashtag.addEventListener("click",event=>{
  hashtagpane.innerText=""
temp=  hashtag_content.value
  channel.push("search_hashtag",
   {hashtag: "xyz".value,tweet: "asd",username: "sdf"})


})

channel.on("search_hashtag",payload=>{
  console.log(payload)
  //let messageItem=document.createElement("li")
  //  console.log(payload.hashtag)
  //  console.log(hashtag_content)
  // console.log(payload.hashtag==hashtag_content.value)

if(payload.hashtag==temp){
  hashtag_content.value=""
  let p=document.createElement("li")
  p.innerText="@"+payload.username+":"+ payload.tweet
  hashtagpane.appendChild(p)
  //alert("@"+payload.username+":"+ payload.tweet)
}
})


channel.on("search_mention",payload=>{

  //let messageItem=document.createElement("li")
  //  console.log(payload.hashtag)
  //  console.log(hashtag_content)
  // console.log(payload.hashtag==hashtag_content.value)

if(payload.mention_username==temp2){
  mention_username.value=""
  let p=document.createElement("li")
  p.innerText="@"+payload.username+":"+ payload.tweet
  mens.appendChild(p)
}
})




// //channel.on("new_msg",payload=>{
//   let messageItem=document.createElement("li")
//   //console.log("hurrayyyyyyyyyyyyyyyy")
//   //console.log(payload.username)
//   //console.log(user.innerText)
//   if (payload.username==user.innerText ){
//     messageItem.innerText=`${payload.username}: ${payload.feed}`
//     messagesContainer.appendChild(messageItem)
//   }


// })
channel.join()
 export default socket
