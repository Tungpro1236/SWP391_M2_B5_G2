package vn.edu.fpt.enums;

public enum Role {
    LEARNER(1),
    INSTRUCTOR(2),
    ADMIN(3);
    
    private final int roleId;
    
    Role(int roleId) {
        this.roleId = roleId;
    }
    
    public int getRoleId() {
        return roleId;
    }
    
    public static Role fromId(int id) {
        for (Role role : Role.values()) {
            if (role.getRoleId() == id) {
                return role;
            }
        }
        throw new IllegalArgumentException("No role found with id: " + id);
    }
}