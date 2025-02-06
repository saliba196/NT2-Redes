# Compilador
CC = gcc

# Flags de compilação
CFLAGS = -Wall -Wextra -std=c99 -O2

# Nomes dos executáveis
CLIENT_EXEC = cliente
SERVER_EXEC = servidor

# Arquivos fonte
CLIENT_SRC = cliente.c rdt_2.2.c
SERVER_SRC = servidor.c rdt_2.2.c

# Regra padrão (compila tudo) - Compila com a versão estática por padrão
all: $(CLIENT_EXEC) $(SERVER_EXEC)

# Regra para compilar o cliente (estático)
$(CLIENT_EXEC): $(CLIENT_SRC) rdt.h
	$(CC) $(CFLAGS) -o $@ $(CLIENT_SRC)

# Regra para compilar o servidor (estático)
$(SERVER_EXEC): $(SERVER_SRC) rdt.h
	$(CC) $(CFLAGS) -o $@ $(SERVER_SRC)

# Regras separadas para versões estática e dinâmica (com e sem -DUSE_DYNAMIC_RDT)
cliente_static: $(CLIENT_SRC) rdt.h
	$(CC) $(CFLAGS) -o cliente_static $(CLIENT_SRC)

cliente_dynamic: $(CLIENT_SRC) rdt.h
	$(CC) $(CFLAGS) -DUSE_DYNAMIC_RDT -o cliente_dynamic $(CLIENT_SRC)

servidor_static: $(SERVER_SRC) rdt.h
	$(CC) $(CFLAGS) -o servidor_static $(SERVER_SRC)

servidor_dynamic: $(SERVER_SRC) rdt.h
	$(CC) $(CFLAGS) -DUSE_DYNAMIC_RDT -o servidor_dynamic $(SERVER_SRC)


# Limpeza dos arquivos gerados
clean:
	rm -f $(CLIENT_EXEC) $(SERVER_EXEC) cliente_static cliente_dynamic servidor_static servidor_dynamic

# Instruções de uso
.PHONY: all clean