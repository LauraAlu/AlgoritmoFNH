

def minimal_uv(a, b):
    if a%b == 0:
        u = 0
        v = 1
        d = b
        return u, v, d
    elif b%a == 0:
        u = 1
        v = 0
        d = a
        return u, v, d

    # Paso 1: Algoritmo extendido de Euclides
    d, u0, v0 = xgcd(a, b)  # u0*a + v0*b = d

    # Buscar el k que minimice |u| y |v| en las condiciones del texto
    for k in range(-abs(b)-200, abs(b)+200):  # rango suficientemente grande
        u = u0 + k * (b // d)
        v = v0 - k * (a // d)

        # Comprobar si satisfacen las condiciones
        if (-abs(a) < v * sign(b) * d <= 0) and (1 <= u * sign(a) <= abs(b) // d):
            return u, v, d

    raise ValueError("No se encontró una solución que satisfaga las condiciones.")


def hermiteEuclideo(A):
    A = Matrix(ZZ, A)  # Convertimos A en una matriz de enteros en Sage
    m, n = A.nrows(), A.ncols()
    U = identity_matrix(ZZ, n)
    i, j, k, l = m, n, n, m-n + 1 if m > n else 1
    flag = False
    step = 1  # Contador de pasos

    while i != -1:
        #Paso 2
        while flag == False:
            if j == 1:
                # Paso 4
                b = A[i-1, k-1]
                if b < 0:
                    A[:, k-1] = -A[:, k-1]
                    U[:, k-1] = -U[:, k-1]
                    b = -b
                    break
                if b == 0:
                    k += 1
                    # Paso 5
                    if i == l:
                        break
                # Tercera parte del Paso 4
                if k < n:
                    for jj in range(k + 1, n + 1):
                        q = A[i-1, jj-1] // b
                        A[:, jj-1] =A[:, jj-1] - q * A[:, k-1]
                        U[:, jj-1] =U[:, jj-1] - q * U[:, k-1]
                    break
                else:
                    break
            else:
                j -= 1

                if A[i-1, j-1] == 0:
                    continue
                else:
                    u, v, d = minimal_uv(A[i-1, k-1],A[i-1, j-1])

                    B = u * A[:, k-1] + v * A[:, j-1]
                    B1 = u * U[:, k-1] + v * U[:, j-1]

                    U[:, j-1] = (A[i-1, k-1] / d) * U[:, j-1] - (A[i-1, j-1] / d) * U[:, k-1]

                    A[:, j-1] = (A[i-1, k-1] / d) * A[:, j-1] - (A[i-1, j-1] / d) * A[:, k-1]


                    U[:, k-1] = B1
                    A[:, k-1] = B
                    print(f"Paso {step}: Después del Paso Euclídeo\n\nMatriz A:\n{A}\n\nMatriz U:\n{U}")
                    step += 1
                    continue


        if i == l:
            break
        else:
            i -= 1
            k -= 1
            j = k
            continue

    print(f"Matriz final en forma normal de Hermite:\n{A}")
    return U

