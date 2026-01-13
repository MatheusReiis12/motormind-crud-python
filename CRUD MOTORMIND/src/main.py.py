#pip install mysql-connector-python
import mysql.connector # pyright: ignore[reportMissingImports]
from mysql.connector import Error # pyright: ignore[reportMissingImports]
import os  # Usaremos para limpar a tela do terminal / linha que comunica com o sistema operacional!

# --- 1. Configuração da Conexão com o Banco de Dados ---
# ATENÇÃO: Substitua pelos seus dados de login do MySQL.
DB_CONFIG = {
    'host': 'localhost',
    'port': 3306, 
    'user': 'root',
    'password': '#jV5MDWJ#?X@$mhlv',
    'database': 'motormind1'
}

def conectar_bd():
    """
    Tenta se conectar ao banco de dados MySQL.
    Retorna o objeto de conexão ou None se falhar.
    """
    try:
        # O operador ** descompacta o dicionário DB_CONFIG
        conexao = mysql.connector.connect(**DB_CONFIG)
        return conexao
    except Error as e:
        # Imprime um erro se a conexão falhar
        print(f"Erro ao conectar ao MySQL (Verifique suas credenciais, porta e se o servidor está no ar): {e}")
        return None

# --- 2. Funções do CRUD (A Lógica do Banco) ---

# --- CREATE (Criar) ---
def inserir_motores1(modelo, potencia, tensao, corrente, rpm, modo_fixacao):
    query = """
        INSERT INTO motores1 (modelo, potencia, tensao, corrente, rpm, modo_fixacao)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    
    conexao = conectar_bd()
    if conexao:
        try:
            cursor = conexao.cursor()
            cursor.execute(query, (modelo, potencia, tensao, corrente, rpm, modo_fixacao))
            conexao.commit()
            print(f"-> Motor '{modelo}' inserido com sucesso (ID: {cursor.lastrowid}).")
        except Error as e:
            print(f"Erro ao inserir dados: {e}")
        finally:
            cursor.close()
            conexao.close()


# --- READ (Ler/Consultar) ---
def listar_motores1():
    """Lista todos os produtos do banco."""
    query = "SELECT * FROM motores1"
    conexao = conectar_bd()
    if conexao:
        try:
            # dictionary=True faz o resultado vir como um dicionário (chave: valor)
            cursor = conexao.cursor(dictionary=True)
            cursor.execute(query)
            resultados = cursor.fetchall()
            
            if not resultados:
                print("-> Nenhum motor cadastrado no sistema.")
                return False # Retorna False para indicar que a lista está vazia

            print("\n--- LISTA DE PRODUTOS ---")
            for f in resultados:
                print(f"ID: {f['id_motor']} | Modelo: {f['modelo']} | potencia: {f['potencia']} | tensao: {f['tensao']} | Corrente: {f['corrente']}| RPM: {f['rpm']} | Fixação: {f['modo_fixacao']}")
            print("---------------------------------")
            return True # Retorna True para indicar que há funcionários
        except Error as e:
            print(f"Erro ao listar dados: {e}")
            return False
        finally:
            cursor.close()
            conexao.close()

# --- UPDATE (Atualizar) --- 
def atualizar_modelo(id_motor, novo_modelo):
    """Atualiza o modelo do motor."""
    query = "UPDATE motores1 SET modelo = %s WHERE id_motor = %s"
    
    conexao = conectar_bd()
    if conexao:
        try:
            cursor = conexao.cursor()
            cursor.execute(query, (novo_modelo, id_motor))
            conexao.commit()
            
            # cursor.rowcount informa quantas linhas foram afetadas
            if cursor.rowcount == 0:
                print(f"-> Nenhum funcionário encontrado com o ID {id_motor}.")
            else:
                print(f"-> Modelo do Motor ID {id_motor} atualizado com sucesso.")
        except Error as e:
            print(f"Erro ao atualizar dados: {e}")
        finally:
            cursor.close()
            conexao.close()

# --- DELETE (Deletar) ---
def deletar_produto(id_motor):
    """Deleta um produto pelo ID."""
    query = "DELETE FROM motores1 WHERE id_motor = %s"
    
    conexao = conectar_bd()
    if conexao:
        try:
            cursor = conexao.cursor()
            cursor.execute(query, (id_motor,))
            conexao.commit()
            
            if cursor.rowcount == 0:
                print(f"-> Nenhum Produto encontrado com o ID {id_motor}.")
            else:
                print(f"-> Produto ID {id_motor} deletado com sucesso.")
        except Error as e:
            print(f"Erro ao deletar dados: {e}")
        finally:
            cursor.close()
            conexao.close()

# --- 3. Funções de Interface (O Menu) ---

def limpar_tela():
    """Limpa o console"""
    os.system('cls' if os.name == 'nt' else 'clear')

def pausar_tela():
    """Pausa a execução e espera o usuário pressionar Enter."""
    input("\nPressione Enter para continuar...")

def mostrar_menu():
    """Exibe o menu principal e retorna a escolha do usuário."""
    limpar_tela()
    print("====================================")
    print("    GERENCIADOR DE MOTORES    ")
    print("====================================")
    print("[1] Listar todos os Motores")
    print("[2] Adicionar novo Motor")
    print("[3] Atualizar especificação de motor")
    print("[4] Deletar motor")
    print("[5] Sair")
    print("====================================")
    return input("Escolha uma opção (1 a 5): ")

# --- 4. Função Principal (Loop do Programa) ---

def main():
    """Função principal que executa o loop do menu."""
    while True:
        escolha = mostrar_menu()

        if escolha == '1':
            # --- LISTAR (READ) ---
            limpar_tela()
            print("--- [1] Listando Motores ---")
            listar_motores1()
            pausar_tela()

        elif escolha == '2':
            # --- ADICIONAR (CREATE) ---
            limpar_tela()
            print("--- [2] Adicionar Novo Motor ---")
            modelo = input("Digite o Modelo: ")
            potencia = input("Digite a Potência: ")
            tensao = input("Digite a Tensão: ")
            corrente = input("Digite a Corrente: ")
            rpm = input("Digite a Rotação por minuto (RPM): ")
            modo_fixacao = input("Digite o modo de Fixação do Motor? (Com flange ou Sem Flange): ")
            
            # Validação simples para não enviar dados vazios
            if modelo.strip() and potencia.strip() and tensao.strip() and corrente.strip() and rpm.strip() and modo_fixacao.strip():
                inserir_motores1 (modelo, potencia, tensao, corrente,rpm,modo_fixacao)
            else:
                print("-> Erro: As informações não podem ser vazias.")
            pausar_tela()

        elif escolha == '3':
            # --- ATUALIZAR (UPDATE) ---
            limpar_tela()
            print("--- [3] Atualizar Modelo do motor ---")
            
            # Mostra a lista primeiro para o usuário saber qual ID editar
            if listar_motores1(): # Só pede o ID se houver funcionários
                try:
                    id_para_atualizar = int(input("\nDigite o ID do Produto que deseja atualizar: "))
                    novo_modelo = input("Digite o NOVO Modelo: ")
                    
                    if novo_modelo.strip():
                        atualizar_modelo (id_para_atualizar, novo_modelo)
                    else:
                        print("-> Erro: O novo modelo não pode ser vazio.")
                except ValueError:
                    print("-> Erro: ID inválido. Por favor, digite um número.")
            pausar_tela()

        elif escolha == '4':
            # --- DELETAR (DELETE) ---
            limpar_tela()
            print("--- [4] Deletar motores ---")
            
            # Mostra a lista primeiro
            if listar_motores1():
                try:
                    id_para_deletar = int(input("\nDigite o ID do motor que deseja DELETAR: "))
                    
                    # Confirmação é crucial para operações de DELETE
                    confirmacao = input(f"Tem CERTEZA que deseja deletar o Motor ID {id_para_deletar}? (s/n): ").lower()
                    
                    if confirmacao == 's':
                        deletar_produto(id_para_deletar)
                    else:
                        print("-> Operação cancelada.")
                except ValueError:
                    print("-> Erro: ID inválido. Por favor, digite um número.")
            pausar_tela()

        elif escolha == '5':
            # --- SAIR ---
            limpar_tela()
            print("Saindo do sistema. Até logo!")
            break

        else:
            # Opção inválida
            print("Opção inválida. Por favor, escolha um número de 1 a 5.")
            pausar_tela()

# --- Ponto de Entrada do Script ---
if __name__ == "__main__":
    main()