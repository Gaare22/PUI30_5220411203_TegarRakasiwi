document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('form-kuisioner');
    if (form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                const firstInvalid = form.querySelector(':invalid');
                const label = firstInvalid.closest('.form-group')?.querySelector('label')?.innerText ||
                              firstInvalid.closest('.question')?.querySelector('p')?.innerText || "Kolom";
                alert(`⚠️ Kolom "${label}" belum diisi.`);
                firstInvalid.focus();
                return false;
            }
        });
    }
});
