// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mysite.roospring.domain;

import com.mysite.roospring.domain.Profile;
import java.util.List;
import java.util.Random;
import org.springframework.stereotype.Component;

privileged aspect ProfileDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ProfileDataOnDemand: @Component;
    
    private Random ProfileDataOnDemand.rnd = new java.security.SecureRandom();
    
    private List<Profile> ProfileDataOnDemand.data;
    
    public Profile ProfileDataOnDemand.getNewTransientProfile(int index) {
        com.mysite.roospring.domain.Profile obj = new com.mysite.roospring.domain.Profile();
        obj.setDisplayName("displayName_" + index);
        obj.setAge(new Integer(index));
        return obj;
    }
    
    public Profile ProfileDataOnDemand.getSpecificProfile(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size() - 1)) index = data.size() - 1;
        Profile obj = data.get(index);
        return Profile.findProfile(obj.getId());
    }
    
    public Profile ProfileDataOnDemand.getRandomProfile() {
        init();
        Profile obj = data.get(rnd.nextInt(data.size()));
        return Profile.findProfile(obj.getId());
    }
    
    public boolean ProfileDataOnDemand.modifyProfile(Profile obj) {
        return false;
    }
    
    public void ProfileDataOnDemand.init() {
        data = com.mysite.roospring.domain.Profile.findProfileEntries(0, 10);
        if (data == null) throw new IllegalStateException("Find entries implementation for 'Profile' illegally returned null");
        if (!data.isEmpty()) {
            return;
        }
        
        data = new java.util.ArrayList<com.mysite.roospring.domain.Profile>();
        for (int i = 0; i < 10; i++) {
            com.mysite.roospring.domain.Profile obj = getNewTransientProfile(i);
            obj.persist();
            obj.flush();
            data.add(obj);
        }
    }
    
}
