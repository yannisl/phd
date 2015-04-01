m = {}

--- fontsdb
--  Table storing commonly found fonts
--  and their human friendly names.
--  
--
 m.fontsdb = {
  arial = { 
    command = 'arial', 
    human = 'Arial.ttf',
    loaded = false,
    win = true,
    linux = true,
    os = false},
  }  

function m.add_font()

end

function m:iffontintable (commandname, fieldname)
  if self.fontsdb[commandname][fieldname] == 'arial' then 
    return true
    else return false
  end
 end 
  
function m:get_font_info(x,command)
  if m:iffontintable (x,'command') then
    if self.fontsdb[x].loaded ==false then
       return 'toload' 
       else return 'loaded'  
    end
  return m.fontsdb[x]
  end
end  
  
 
  
--print(m.fontsdb['arial']['command'], m:iffontintable('arial','command')) 
--m:get_font_info('arial')


return m