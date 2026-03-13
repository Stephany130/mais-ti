// função de validação de senha reutilizável
// requisito: pelo menos 6 caracteres
function validatePassword(pw) {
    if (pw.length < 6) {
        return false;
    }
    return true;
}

/* função de validação de e-mail simples para uso em validateForm */
function validateEmail(email) {
    // divisão simples para validar estrutura local@dominio
    const parts = email.split('@');
    if (parts.length !== 2) {
        return false;
    }
    const local = parts[0];
    const domain = parts[1];

    // helper para checar letra inicial
    function isLetter(ch) {
        return (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z');
    }

    // local deve ter ao menos um caractere e começar com letra
    if (local.length < 1 || !isLetter(local[0])) {
        return false;
    }

    // domínio dividido por pontos e cada parte deve ter pelo menos um caractere e começar com letra
    const domainParts = domain.split('.');
    if (domainParts.length < 2) {
        return false;
    }
    for (const part of domainParts) {
        if (part.length < 1 || !isLetter(part[0])) {
            return false;
        }
    }

    return true;
}