package br.com.firston.wizard.sample;

import br.com.firston.wizard.Wizard;
import br.com.firston.wizard.WizardPanelDescriptor;

public class Main {
    
    public static void main(String[] args) {
        
        Wizard wizard = new Wizard();
        wizard.getDialog().setTitle("Seu Jeito Bar - Criar Cardápio");
        
        WizardPanelDescriptor descriptor1 = new TestPanel1Descriptor();
        wizard.registerWizardPanel(TestPanel1Descriptor.IDENTIFIER, descriptor1);

        WizardPanelDescriptor descriptor2 = new TestPanel2Descriptor();
        wizard.registerWizardPanel(TestPanel2Descriptor.IDENTIFIER, descriptor2);

        WizardPanelDescriptor descriptor3 = new TestPanel3Descriptor();
        wizard.registerWizardPanel(TestPanel3Descriptor.IDENTIFIER, descriptor3);
        
        wizard.setCurrentPanel(TestPanel1Descriptor.IDENTIFIER);
        
        int ret = wizard.showModalDialog();
        
        System.out.println("Dialog return code is (0=Finish,1=Cancel,2=Error): " + ret);
        System.out.println("Second panel selection is: " + 
            (((TestPanel2)descriptor2.getPanelComponent()).getRadioButtonSelected()));
        
        System.exit(0);
        
    }
    
}
