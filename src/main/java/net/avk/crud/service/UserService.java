package net.avk.crud.service;

import net.avk.crud.model.User;

import java.util.List;

public interface UserService {
    public void addUser(User user);
    public void updateUser(User user);
    public void removeUser(int id);
    public User getUserById(int id);
    public List<User> listUserByName(String name);
    public List<User> listUsers();
}
