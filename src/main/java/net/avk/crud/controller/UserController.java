package net.avk.crud.controller;

import net.avk.crud.model.User;
import net.avk.crud.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.beans.support.SortDefinition;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class UserController {
    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String listUsers(@RequestParam (required = false) Integer page, Model model){
        int pageSize = 10;
        PagedListHolder<User> pagedListHolder =
                new PagedListHolder<User>(this.userService.listUsers());
        pagedListHolder.resort();
        pagedListHolder.setPageSize(pageSize);
        if(page==null || page < 1 || page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            page = 1;
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
        }
        model.addAttribute("lastPage", pagedListHolder.getPageCount());
        model.addAttribute("page", page);
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", pagedListHolder.getPageList());
        return "users";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
        if (user.getId() == 0) {
            this.userService.addUser(user);
        }
        else {
            this.userService.updateUser(user);
        }
        return "redirect: /users";
    }
    @RequestMapping(value = "/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);
        return "redirect: /users";
    }

    @RequestMapping(value = "edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("listUsers", this.userService.listUsers());
        return "users";
    }

    @RequestMapping(value = "/userdataid/{id}")
    public String listUserById(@RequestParam("id") int id, Model model){
        try {
            model.addAttribute("user", new User());
            model.addAttribute("user", this.userService.getUserById(id));
            return "userdataid";
        }catch (Exception e) {return "redirect: /users";}
    }

    @RequestMapping(value = "/userdataname", method = RequestMethod.GET)
    public String listUserByName(@RequestParam("name") String name, Model model){
        try {
            model.addAttribute("user", new User());
            model.addAttribute("listUserByName", this.userService.listUserByName(name));
            return "userdataname";
        } catch (Exception e) {return "redirect: /users";}
    }
}
