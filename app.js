const samples = [
 {title:"Tusaale Anime 1",genre:"Adventure",description:"Ku beddel xogtaada anime sharci ahaan loo oggolaaday."},
 {title:"Tusaale Anime 2",genre:"Drama",description:"Tusaale muuqaal ah oo kaliya; ma laha video."}
];
const grid=document.getElementById("animeGrid");
function render(items){grid.innerHTML="";items.forEach(a=>{const card=document.createElement("article");card.className="anime-card";const poster=document.createElement("div");poster.className="poster";poster.textContent="🎬";const h=document.createElement("h3");h.textContent=a.title;const g=document.createElement("p");g.textContent=a.genre;const d=document.createElement("p");d.textContent=a.description;card.append(poster,h,g,d);grid.append(card)});document.getElementById("count").textContent=items.length+" muuqaal"}
render(samples);
document.getElementById("search").addEventListener("input",e=>{const q=e.target.value.toLowerCase();render(samples.filter(x=>(x.title+" "+x.genre).toLowerCase().includes(q)))});
const dlg=document.getElementById("authDialog");
document.getElementById("loginBtn").onclick=()=>dlg.showModal();
document.querySelector(".close").onclick=()=>dlg.close();
document.getElementById("saveConfig").onclick=()=>{const url=document.getElementById("projectUrl").value.trim(),key=document.getElementById("publishableKey").value.trim();if(!url.startsWith("https://")||!key.startsWith("sb_publishable_")){document.getElementById("configStatus").textContent="Hubi Project URL iyo Publishable key-ga.";return}localStorage.setItem("sa_project_url",url);localStorage.setItem("sa_publishable_key",key);document.getElementById("configStatus").textContent="Dejinta waxaa lagu kaydiyey qalabkan. Isku xirka Auth/Storage weli wuxuu u baahan yahay dejin dheeraad ah."};
if("serviceWorker" in navigator)window.addEventListener("load",()=>navigator.serviceWorker.register("./sw.js").catch(()=>{}));
