(function(){
  "use strict";
  var form=document.getElementById("lead-form");
  if(form){
    form.addEventListener("submit",async function(event){
      event.preventDefault();
      var button=form.querySelector("button");
      var status=form.querySelector(".form-status");
      var data=new FormData(form);
      var payload={name:String(data.get("name")||"").trim(),email:String(data.get("email")||"").trim().toLowerCase(),challenge:String(data.get("challenge")||"sobrecarga"),consent:data.get("consent")==="on",source:"landing-rotina-leve"};
      if(payload.name.length<2||!/^\S+@\S+\.\S+$/.test(payload.email)||!payload.consent){status.textContent="Revise seu nome, e-mail e consentimento.";status.className="form-status error";return;}
      button.disabled=true;button.textContent="Preparando seu acesso…";status.textContent="";
      try{
        var config=window.ROTINA_LEVE_CONFIG||{};
        if(config.leadsApiUrl){var response=await fetch(config.leadsApiUrl,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(payload)});if(!response.ok){throw new Error("Não foi possível concluir o cadastro.");}}
        sessionStorage.setItem("rotina_leve_nome",payload.name);
        window.location.href="obrigado.html";
      }catch(error){status.textContent=error.message||"Tente novamente em alguns instantes.";status.className="form-status error";button.disabled=false;button.textContent="Quero receber gratuitamente";}
    });
  }
  if("serviceWorker" in navigator&&location.protocol.startsWith("http")){window.addEventListener("load",function(){navigator.serviceWorker.register("sw.js").catch(function(){});});}
})();

