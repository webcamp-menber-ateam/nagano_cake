
[1mFrom:[0m /home/ec2-user/environment/nagano_cake/app/views/public/addresses/index.html.erb:35 #<Class:0x00007fbba91026f8>#_app_views_public_addresses_index_html_erb___1128617430272432871_36700:

    [1;34m30[0m:     </div>
    [1;34m31[0m:     <% if session[:address]["postcode"].present? %>
    [1;34m32[0m:       <% session[:address].clear %>
    [1;34m33[0m:     <% end %>
    [1;34m34[0m:     <% binding.pry%>
 => [1;34m35[0m: 
    [1;34m36[0m:     <div class="form-group row">
    [1;34m37[0m:       <div class="col-3">
    [1;34m38[0m:         <%= f.label :"宛名", class: 'ml-4 mt-1'%>
    [1;34m39[0m:       </div>
    [1;34m40[0m:       <div class="col-7">

