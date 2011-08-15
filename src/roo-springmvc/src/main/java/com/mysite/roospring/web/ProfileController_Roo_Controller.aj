// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mysite.roospring.web;

import com.mysite.roospring.domain.Profile;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ProfileController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST)
    public String ProfileController.create(@Valid Profile profile, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("profile", profile);
            return "profiles/create";
        }
        profile.persist();
        return "redirect:/profiles/" + encodeUrlPathSegment(profile.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ProfileController.createForm(Model model) {
        model.addAttribute("profile", new Profile());
        return "profiles/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String ProfileController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("profile", Profile.findProfile(id));
        model.addAttribute("itemId", id);
        return "profiles/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ProfileController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("profiles", Profile.findProfileEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Profile.countProfiles() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("profiles", Profile.findAllProfiles());
        }
        return "profiles/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ProfileController.update(@Valid Profile profile, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("profile", profile);
            return "profiles/update";
        }
        profile.merge();
        return "redirect:/profiles/" + encodeUrlPathSegment(profile.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ProfileController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("profile", Profile.findProfile(id));
        return "profiles/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String ProfileController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Profile.findProfile(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/profiles?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    String ProfileController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}