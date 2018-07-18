package br.com.firston.wizard.sample;

import br.com.firston.wizard.WizardPanelDescriptor;


public class TestPanel1Descriptor extends WizardPanelDescriptor {
    
    public static final String IDENTIFIER = "INTRODUCTION_PANEL";
    
    public TestPanel1Descriptor() {
        super(IDENTIFIER, new TestPanel1());
    }
    
    public Object getNextPanelDescriptor() {
        return TestPanel2Descriptor.IDENTIFIER;
    }
    
    public Object getBackPanelDescriptor() {
        return null;
    }  
    
}
