package net.avk.crud.dao;

import net.avk.crud.model.User;
import java.util.List;

public interface UserDao {
    public void addUser(User user);
    public void updateUser(User user);
    public void removeUser(int id);
    public User getUserById(int id);
    public List<User> listUserByName(String name);
    public List<User> listUsers();
}
