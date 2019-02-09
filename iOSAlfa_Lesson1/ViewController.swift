//
//  ViewController.swift
//  iOSAlfa_Lesson1
//
//  Created by Faculdade Alfa on 09/02/2019.
//  Copyright © 2019 Faculdade Alfa. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var edtValorGasolina:UITextField!
    @IBOutlet var edtvalorEtanol:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calcular() {
        
        guard let valorGasolina = Double(edtValorGasolina.text!) else {
            mostrarMensagem(titulo: "Aula Alfa", texto: "Campo gasolina vazio ou inválido!")
            return
        }
        
        guard let valorEtanol = Double(edtvalorEtanol.text!) else {
            mostrarMensagem(titulo: "Aula Alfa", texto: "Campo etanol vazio ou inválido!")
            return
        }
        
        if (valorEtanol <= (valorGasolina * 0.7)) {
            mostrarMensagem(titulo: "Aula Alfa", texto: "Etanol é melhor!")
        } else {
            mostrarMensagem(titulo: "Aula Alfa", texto: "Gasolina é melhor!")
        }
    }

    private func mostrarMensagem(titulo: String, texto: String) {
        let alerta = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
        let acaoOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let acaoLoop = UIAlertAction(title: "Loop", style: .cancel) {
            UIAlertAction in
            self.mostrarMensagem(titulo: "Aula Alfa", texto: "Loop")
        }
        alerta.addAction(acaoLoop)
        alerta.addAction(acaoOk)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func compartilhar() {
        let alerta = UIAlertController(title: "Compartilhar", message: "Escolha onde vai compartilhar", preferredStyle: .actionSheet)
        
        let email = UIAlertAction(title: "E-mail", style: .default) {
            UIAlertAction in
            self.enviarEmail()
        }
        
        let whatsapp = UIAlertAction(title: "Whatsapp", style: .default) {
            UIAlertAction in
            self.enviarWhatsapp()
        }
        
        
        alerta.addAction(email)
        alerta.addAction(whatsapp)
        
        alerta.addAction(UIAlertAction(title: "Voltar", style: .cancel, handler: nil))
        
        present(alerta, animated: true, completion: nil)
    }
    
    private func textoCompartilhar() -> String {
        let retorno = "Gasolina: \(edtValorGasolina.text!). Etanol: \(edtvalorEtanol.text!)"
        
        return retorno
    }
 
    private func enviarEmail() {
        if (MFMailComposeViewController.canSendMail()) {
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setToRecipients(["leo.morini.nn@gmail.com"])
            email.setSubject("Assunto do E-Mail")
            email.setMessageBody(textoCompartilhar(), isHTML: true)
            present(email, animated: true, completion: nil)
            
        } else {
            mostrarMensagem(titulo: "Aula Alfa", texto: "Não é possível enviar e-mail!")
        }
    }
    
    private func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func enviarWhatsapp() {
        if let chamarLink = URL(string: "https://api.whatsapp.com/phone=5544984037439&text=Aula%20Alfa") {
            UIApplication.shared.open(chamarLink, options: [:], completionHandler: nil)
        }
    }
    
}

